# Train-Seat-Finder-Using-Flutter

This application implements a seat finder interface.Which allows user to enter a seat number abd see the details of the selected seat. Created a 'runApp' method to start the flutter application by creating a instance of the 'SeatFinderApp' widget.Then created a 'SeatFinderApp' class which is a stateless widget that represents the entire application.It sets the title and theme of the application.
'SeatFinderScreen' class is a stateful widget that represents the screen of the application of the seat finder. The 'SeatfinderScreen' class contains array that stores seats available.It also stores total numbers seats and keep track of available seats from the selected seats.
The 'findseat()' method is called when the user clicks the "Find" button and the build method constructs the user interface using flutter widget.The seat Grid is displayed using GridView.builder'.
