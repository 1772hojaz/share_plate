#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>
#include <vector>  // Include vector header

#include "flutter_window.h"
#include "utils.h"  // Include the header where CreateAndAttachConsole is declared

// Entry point for the application
int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t* command_line, _In_ int show_command) {
    // Attach to console when present (e.g., 'flutter run') or create a
    // new console when running with a debugger.
    if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
        CreateAndAttachConsole();  // Call the function declared in utils.h
    }

    // Initialize COM, so that it is available for use in the library and/or
    // plugins.
    ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

    flutter::DartProject project(L"data");

    // Ensure GetCommandLineArguments is defined and returns std::vector<std::string>
    std::vector<std::string> command_line_arguments = GetCommandLineArguments();
    project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

    // Create a Flutter window
    FlutterWindow window(project);
    Win32Window::Point origin(10, 10);
    Win32Window::Size size(1280, 720);

    // Adjust window title based on your preference
    if (!window.Create(L"Share Plate App", origin, size)) {
        return EXIT_FAILURE;
    }

    // Set the application to quit when the window is closed
    window.SetQuitOnClose(true);

    // Main message loop
    ::MSG msg;
    while (::GetMessage(&msg, nullptr, 0, 0)) {
        ::TranslateMessage(&msg);
        ::DispatchMessage(&msg);
    }

    // Uninitialize COM
    ::CoUninitialize();
    return EXIT_SUCCESS;
}
