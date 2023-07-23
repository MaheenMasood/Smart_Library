
import 'dart:io';

List<Map<String, String>> adminUsers = [];
List<Map<String, String>> regularUsers = [];
// List to store books
List<Map<String, dynamic>> books = [
    {
    'title': 'DSA',
    'author': 'Author 1',
    'category': 'Category 1',
    'availableCopies': 5,
    'fineRate': 100,
  },
  {
    'title': 'OPP',
    'author': 'Author 2',
    'category': 'Category 2',
    'availableCopies': 8,
    'fineRate': 300,
  },]; 
// Map to store borrowed books with due dates
Map<String, DateTime> borrowedBooks = {}; 

bool isValidEmail(String email) {
  // Basic email validation using a simple regular expression
  final emailRegExp = RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
  return emailRegExp.hasMatch(email);
}

bool isValidPassword(String password) {
  // Password should not be less than 8 characters
  return password.length >= 8;
}

void adminSignup() {
  var Code= "749admin";
  stdout.write('Enter admin email: ');
  /*The trim() method removes whitespace from both ends 
  of a string and returns a new string, without modifying the original string.*/
  String? email = stdin.readLineSync()?.trim();
  stdout.write('Enter admin 8 digit long password: ');
  String? password = stdin.readLineSync();

  if (email != null && password != null && isValidEmail(email) && isValidPassword(password)) {
    Map<String, String> admin = {'email': email, 'password': password};
    adminUsers.add(admin);
    stdout.write("Enter Admin's Code: ");
    String? code = stdin.readLineSync();
    if(code==Code){
    print('\n::: Admin signup successful! :::');}
    if (code!=Code){
      print("::: invalid Code :::");
    }
  }
   else {
    print('\nInvalid email or password.\nAdd "@gmail.com" with your email ID\nAdd Minimum 8 digit long Password\n ::: Signup failed :::');
  }
}

void userSignup() {
  stdout.write('Enter user email: ');
  String? email = stdin.readLineSync()?.trim();
  stdout.write('Enter user password: ');
  String? password = stdin.readLineSync();

  if (email != null && password != null && isValidEmail(email) && isValidPassword(password)) {
    Map<String, String> user = {'email': email, 'password': password};
    regularUsers.add(user);

    print('\n::: User signup successful! :::');
  } else {
    print('\nInvalid email or password.\nAdd "@gmail.com" with your email ID\nAdd Minimum 8 digit long Password\n::: Signup failed :::');
  }
}



void adminLogin() {
  stdout.write('Enter admin email: ');
  String? email = stdin.readLineSync();
  stdout.write('Enter admin password: ');
  String? password = stdin.readLineSync();

  if (email != null && password != null) {
    bool adminFound = false;
    for (var user in adminUsers) {
      if (user['email'] == email && user['password'] == password) {
        adminFound = true;
        break;
      }
    }

    if (adminFound) {
      print('\n::: Admin login successful! :::');
      showAdminInfo();
      // Perform admin-specific operations
    } else {
      print('\n::: Invalid admin credentials. :::');
    }
  } else {
    print('\n::: Invalid input. Login failed. :::');
  }
}

void userLogin() {
  stdout.write('Enter user email: ');
  String? email = stdin.readLineSync();
  stdout.write('Enter user password: ');
  String? password = stdin.readLineSync();

  if (email != null && password != null) {
    bool userFound = false;
    for (var user in regularUsers) {
      if (user['email'] == email && user['password'] == password) {
        userFound = true;
        break;
      }
    }

    if (userFound) {
      print('\n::: User login successful! :::');
      showUserInfo();
      // Perform user-specific operations
    } else {
      print('\n::: Invalid user credentials. :::');
    }
  } else {
    print('\n::: Invalid input. Login failed.:::');
  }
}
void showAdminInfo() {
  while (true) {
    print('\nLibrary Information for Admin:');
    print('1. Add Book');
    print('2. Update Book');
    print('3. Delete Book');
    print('4. View Books');
    print('5. Exit');

    stdout.write('Enter your choice: ');
    String? choice = stdin.readLineSync();

    if (choice != null) {
      switch (choice) {
        case '1':
          addBook();
          break;
        case '2':
          updateBook();
          break;
        case '3':
          deleteBook();
          break;
        case '4':
          viewBooks();
          break;
        case '5':
          return; // Exit the showAdminInfo function
        default:
          print('\nInvalid choice.');
      }
    } else {
      print('\nInvalid input.');
    }
  }
}

void updateBook() {
  stdout.write('Enter the title of the book to update: ');
  String? titleToUpdate = stdin.readLineSync()?.trim();
  
  int bookIndex = -1;
  for (int i = 0; i < books.length; i++) {
    if (books[i]['title'] == titleToUpdate) {
      bookIndex = i;
      break;
    }
  }

  if (bookIndex != -1) {
    stdout.write('Enter new title (Leave empty to keep the same): ');
    String? newTitle = stdin.readLineSync()?.trim();
    stdout.write('Enter new author (Leave empty to keep the same): ');
    String? newAuthor = stdin.readLineSync()?.trim();
    stdout.write('Enter new number of available copies (Enter -1 to keep the same): ');
    int? newAvailableCopies = int.tryParse(stdin.readLineSync()!);

    if (newTitle != null && newTitle.isNotEmpty) {
      books[bookIndex]['title'] = newTitle;
    }
    if (newAuthor != null && newAuthor.isNotEmpty) {
      books[bookIndex]['author'] = newAuthor;
    }
    if (newAvailableCopies != null && newAvailableCopies >= 0) {
      books[bookIndex]['availableCopies'] = newAvailableCopies;
    }

    print('\n::: Book updated successfully! :::');
  } else {
    print('\n::: Book not found. :::');
  }
}

void deleteBook() {
  stdout.write('Enter the title of the book to delete: ');
  String? titleToDelete = stdin.readLineSync()?.trim();
  
  int bookIndex = -1;
  for (int i = 0; i < books.length; i++) {
    if (books[i]['title'] == titleToDelete) {
      bookIndex = i;
      break;
    }
  }

  if (bookIndex != -1) {
    books.removeAt(bookIndex);
    print('\n::: Book deleted successfully! :::');
  } else {
    print('\n::: Book not found. :::');
  }
}

void viewBooks() {
   print("--------------------------------------------------"
       "\nEnjoy every page 📚, but remember the due date!📅 "
       "\n     Overdue books may come with a fine.💸"       
       "\n          Happy reading!🌟"
       "\n--------------------------------------------------");
  print('\nBooks in the library:');
  if (books.isEmpty) {
    print('\n::: No books available.:::');
  } else {
    for (var book in books) {
      print('${book['title']} by ${book['author']}, Category: ${book['category']}, Available Copies: ${book['availableCopies']}, Fine per day: ${book['fineRate']}');
    }
  }
}
void addBook() {
  stdout.write('Enter book title: ');
  String? title = stdin.readLineSync()?.trim();
  stdout.write('Enter book author: ');
  String? author = stdin.readLineSync()?.trim();
  stdout.write('Enter book category: ');
  String? category = stdin.readLineSync()?.trim();
  stdout.write('Enter the number of available copies: ');
  int? availableCopies = int.tryParse(stdin.readLineSync()!);
  stdout.write('Enter the Fine : ');
  int? fineRate = int.tryParse(stdin.readLineSync()!);

  if (title != null && author != null && category != null && availableCopies != null && availableCopies >= 0&&fineRate!=null) {
    Map<String, dynamic> book = {
      'title': title,
      'author': author,
      'category': category,
      'availableCopies': availableCopies,
      'fineRate': fineRate,
    };
    books.add(book);

    print('\n::: Book added successfully! :::');
  } else {
    print('\n::: Invalid input. Adding book failed. ::: ');
  }
}

void showUserInfo() {
  while (true) {
    print('\nUser Information:');
    print('1. View Books');
    print('2. Borrow Book');
    print('3. Return Book');
    print('4. Exit');

    stdout.write('Enter your choice: ');
    String? choice = stdin.readLineSync();

    if (choice != null) {
      switch (choice) {
        case '1':
          viewBooks();
          break;
        case '2':
          borrowBook();
          break;
        case '3':
          returnBook();
          break;
        case '4':
          return; // Exit the showUserInfo function
        default:
          print('::: Invalid choice. :::');
      }
    } else {
      print('::: Invalid input. :::');
    }
  }
}
void borrowBook() {
  stdout.write('Enter your email: ');
  String? userEmail = stdin.readLineSync()?.trim();
  stdout.write('Enter the title of the book you want to borrow: ');
  String? titleToBorrow = stdin.readLineSync()?.trim();
  
  if (userEmail != null && userEmail.isNotEmpty && titleToBorrow != null && titleToBorrow.isNotEmpty) {
    int bookIndex = -1;
    for (int i = 0; i < books.length; i++) {
      if (books[i]['title'] == titleToBorrow) {
        bookIndex = i;
        break;
      }
    }

    if (bookIndex != -1) {
      if (books[bookIndex]['availableCopies'] > 0) {
        books[bookIndex]['availableCopies']--;
        // Set the due date to 7 days from today
        DateTime dueDate = DateTime.now().add(Duration(days: 7));
        borrowedBooks[userEmail] = dueDate;
        print('\n::: You have successfully borrowed ${books[bookIndex]['title']}. :::');
        print('::: Please return it on or before ${dueDate.toLocal()} :::');
      } else {
        print('\nThe book is currently unavailable. Please try again later.');
      }
    } else {
      print('\n::: Book not found.::: ');
    }
  } else {
    print('\nInvalid input. Please enter your email and the title of the book you want to borrow.');
  }
}

void returnBook() {
  stdout.write('Enter your email: ');
  String? userEmail = stdin.readLineSync()?.trim();
  stdout.write('Enter the title of the book you want to return: ');
  String? titleToReturn = stdin.readLineSync()?.trim();
  
  if (userEmail != null && userEmail.isNotEmpty && titleToReturn != null && titleToReturn.isNotEmpty) {
    int bookIndex = -1;
    for (int i = 0; i < books.length; i++) {
      if (books[i]['title'] == titleToReturn) {
        bookIndex = i;
        break;
      }
    }

    if (bookIndex != -1) {
      if (borrowedBooks.containsKey(userEmail) && borrowedBooks[userEmail] != null) {
        DateTime dueDate = borrowedBooks[userEmail]!;
        DateTime currentDate = DateTime.now();
        if (currentDate.isAfter(dueDate)) {
          // Calculate fine based on the number of overdue days
          var overdueDays = currentDate.difference(dueDate).inDays;
          var fineRate = books[bookIndex]['fineRate'] ?? 0.0;
          var fineAmount = fineRate * overdueDays;
          print('You have returned ${books[bookIndex]['title']} ${overdueDays} day(s) overdue.');
          print('Your fine amount is \$${fineAmount.toStringAsFixed(2)}.');
          // Apply the fine to the user account or take other necessary actions
        }
        books[bookIndex]['availableCopies']++;
        borrowedBooks.remove(userEmail);
        print('\n::: You have successfully returned ${books[bookIndex]['title']}. :::');
      } else {
        print('\n::: You have not borrowed ${books[bookIndex]['title']}. :::');
      }
    } else {
      print('\n::: Book not found. :::');
    }
  } else {
    print('\nInvalid input. Please enter your email and the title of the book you want to return.');
  }
}


void main() {
  print("\n========================================\n"
          "||    WELCOME TO SMART LIBRARY 📚📚   ||\n"
          "========================================");
  
  print('\n"Unlock the Doors to Knowledge and Imagination!" \n');        
  while (true) {
    print('1. Admin Signup');
    print('2. User Signup');
    print('3. Admin Login');
    print('4. User Login');
    print('5. Exit');

    stdout.write('Enter your choice: ');
    String? choice = stdin.readLineSync();

    if (choice != null) {
      switch (choice) {
        case '1':
          adminSignup();
          break;
        case '2':
          userSignup();
          break;
        case '3':
          adminLogin();
          break;
        case '4':
          userLogin();
          break;
        case '5':
          exit(0);
          break;
        default:
          print('\nInvalid choice.');
      }
    } else {
      print('\nInvalid input.');
    }

    print('\n');
  }
}
