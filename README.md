Documentation for the Flutter Powstik app



Implemented features: 

    - Login

    - Signup

    - Password Reset via Email

    - E-commerce page to browse and select items

    - Cart page to view items in the cart remove items or change their quantity

    - Checkout Page to see a summary of the transaction and proceed to payment

    - Search feature to search for products

    - Backend for storing user cart info using Firebase

Instructions:

    - After making a clone of the app, make sure your computer has the requirements to run the development app

    - Run "flutter doctor" to see if your computer has the requirements.

    - Make sure to run "flutter pub get".

    - The app has two users by default with the following credentials

        - Email: a@gmail.com, Password: 1234567890
        - Email: b@gmail.com, Password: 1234567890

    - Login using these existing credentials or create your own account.

    - In case you forgot your password, select the "Forgot Your Password?" option. enter you email address associated with your powstik account.

    - You will get a passwor reset link in your email.

    - Login after resetting your password.


    AFTER LOGGING IN:

        - Browse the products

        - Search for the products by their name using the search bar

        - To add a product to your cart, select its quantity (default: 1) and click on the "Add to Cart" button.

        - To see your current cart, click on the cart icon on the top right corner of the screen.

        - You can change the quantity of a item or remove it from your cart.

        - To checkout, click on the "Checkout" button in the top right corner of the page.

        - You can only view teh checkout page if you have some items in your cart.

        - On the checkout screen, you will be shown a summary of your purchase.

        - Once you click on checkout, the payment will be completed and your cart will be emptied adn you will be redirected to the Ecommerce/Browse page.

        - In the production build of teh application, the checkout button will reedirect to the payment gateway and on successful payment the user's cart will be cleared amd the user will be redirected to the Ecommerce/Browse page.


    TO LOG OUT:
        - In order to log out, click on the "logout" button in the top left corner of the Ecommerce/Browse page.



    SPECIAL FEATURES OF CODE:

        - The theme of the app is set at the highest level and passed down to the children which ensures a single point of control, making it easy to control the themeing of the entire app.

        - The project structure has been divided into meaningful components (folders) like "components/" containing reusable custom Widget classes (components). The "routes/" folder contains all the pages that that app has that can be navigated.


    NOTE: As of now the list of products is hard coded but in the production app, the products will be selected from the Powstik product database.