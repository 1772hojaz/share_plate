# SharePlate Rwanda

SharePlate Rwanda is a mobile application designed to address food waste and food insecurity in Rwanda. By connecting food donors and recipients, SharePlate ensures that excess food reaches those in need while promoting a sustainable food ecosystem.

---

## Mission
Our mission is to reduce food waste and fight hunger by creating a platform where individuals and organizations can share surplus food with those in need. SharePlate aims to foster a culture of giving and sustainability in Rwanda.

---

## Problem We Are Solving
Food insecurity affects many communities in Rwanda, while significant amounts of food are wasted daily. SharePlate bridges this gap by enabling efficient food sharing, reducing waste, and supporting individuals struggling to access nutritious meals.

---

## Features
- **Donate Food**: Allows users to share surplus food.
- **Receive Food**: Connects users with available food items.
- **Real-Time Chat**: Facilitates communication between donors and recipients.
- **Secure Authentication**: Ensures a safe and trusted environment.
- **User-Friendly Interface**: Simplifies navigation for all users.

---

## Setup Instructions
### Prerequisites
- Flutter SDK installed on your machine.
- Android Studio or a physical Android/iOS device.
- Firebase account for authentication and database services.

### Steps to Run the App
1. Clone this repository:  
   ```bash
   git clone https://github.com/<your-repo>/shareplate.git

2. Navigate to the project directory and run:
    ```bash
    cd shareplate
    flutter pub get
    flutter run

##### 🔒 **Authentication & Security Rules**

### **Authentication**
SharePlate uses **Firebase Authentication** to manage user access securely:  
- **Login Options**: Users can log in with an **email and password**.  
- **Session Management**: Token-based authentication ensures secure and persistent user sessions.  
- **Role-Based Access**: Users are assigned roles (e.g., donor, recipient) for tailored app functionality.

---

### **Security Rules**
To protect user data and maintain privacy, the following **Firestore security rules** are implemented:

1. **User Authentication**:
   - Only authenticated users can access or modify data.
   ```json
   allow read, write: if request.auth != null;

