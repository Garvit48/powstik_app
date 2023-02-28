Documentation for the Flutter Powstik app

Implemented features: 
    - Login
    - Signup
    - Password Reset via Email
    - E-commerce page to browse and select items
    - Cart page to view items in the cart remove items or change their quantity
    - Search feature to search for products
    - Backend for storing user cart info using Firebase

Instructions:
    - After making a clone of the app, make sure your computer had the requirements to run the development app
    - Make sure to run "flutter pub get"
    - The app has two users by default with the following credentials
        - Email: a@gmail.com, Password: 1234567890
        - Email: b@gmail.com, Password: 1234567890
    - Login using these existing credentials or create your own account.
    - In case you forgot your password, select the "Forgot Your Password?" option. enter you email address associated with youir powstik account.
    - You will get a passwor reset link in your email.
    - Login after resetting your password.


    AFTER LOGGING IN:
        - Browse the products
        - Search for the products by their name using the search bar
        - To add a product to your cart, select its quantity (default: 1) and click on the "Add to Cart" button.
        - To see your current cart, click on the cart icon on the top right corner of the screen.
        - You can change the quantity of a item or remove it from your cart.

    TO LOG OUT:
        - In order to log out, click on the "locgout" button in the top left corner of the page



    NOTE: As of now the list of products is hard coded but in the production app, the products will be selected from the Powstik product database.