# Data Bases

This is a repository about the DBlab project for the cooking contest of the 6th semester of ECE-NTUA

Authors:
+ Nikolaos ([orion-3464](https://github.com/orion-3464)) Kordas
+ Nikolaos ([nikostsalkitzis](https://github.com/nikostsalkitzis)) Tsalkitzis
+ Dimitrios ([DimPanta](https://github.com/DimPanta)) Pantazis

# Languages and Technologies

![XAMPP](https://upload.wikimedia.org/wikipedia/en/thumb/7/78/XAMPP_logo.svg/180px-XAMPP_logo.svg.png)
![MySQL](https://upload.wikimedia.org/wikipedia/labs/8/8e/Mysql_logo.png)
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Apache_Feather_Logo.svg/1158px-Apache_Feather_Logo.svg.png" width="200" height="200">

Το XAMPP είναι ακρωνύμιο που αντιπροσωπεύει τα παρακάτω:
+ Χ: Cross - Platform
+ A: Apache HTTP server
+ P: PHP
+ P: Perl

Με άλλα λόγια, προσφέρει ένα ολοκληρωμένο Web Development Stack για την ανάπτυξη και την δοκιμή της βάσης μας. Η βάση δεδομένων που χρησιμοποιεί και το ίδιο κάναμε και εμείς είναι η MySQL. Για να εγκαταστήσει κανείς τις παραπάνω πλατφόρμες αρκεί να ακολουθήσει τις οδηγίες των διαφανειών του μαθήματος https://helios.ntua.gr/pluginfile.php/186097/mod_resource/content/7/lab1.pdf

# MySQL Workbench

![MySQL Workbench](https://miro.medium.com/v2/resize:fit:1400/0*76Qpy69zDxWCNGaG.jpg)

Πρόκειται για ένα γραφικό εργαλείο που χρησιμοποιήθηκε τόσο για την ανάπτυξη όσο και για το testing της βάσης μας. Η εφαρμογή μας είναι πλήρως λειτουργική μέσα από αυτό. Μπορεί να γίνει σύνδεση του περιβάλλοντος του XAMPP με το Workbench και η εκτέλεση του κώδικα SQL και άρα η επίδειξη της εφαρμογής να γίνει από το τελευταίο.

# Project Structure

+ `/cooking-contest-db/cooking-contest-schema.sql`: Είναι το DDL script που περιέχει τους ορισμούς των σχέσεων, των προβολών, των συναρτήσεων και των εναυσμάτων της βάσης.

+ `/cooking-contest-db/cooking-contest-insert-data.sql`: Πρόκειται για το DML script που περιέχει τα δεδομένα που φορτώνονται στη βάση.

+ `/cooking-contest-db/cooking-contest-users.sql`: Περιέχει τον κώδικα που είναι υπεύθυνος για την δημιουργία των χρηστών της εφαρμογής και για την παροχή των privileges σε αυτούς.

+ `/cooking-contest-db/cooking-contest-queries.sql`: Περιέχει τα queries που ζητούνται στο ερώτημα 3 της εξαμηνιαίας εργασίας.

+ Οι φάκελοι `cooks`, `ingredients`, `gears`, `theme_category`, `food_group`, `recipes` περιέχουν τις εικόνες που φορτώνονται ως blob στη βάση δεδομένων μας.

+ Οι φάκελοι `ER_Diagram` και `Relational` περιέχουν τα διαγράμματα ER και Relational αντίστοιχα (τόσο τη φωτογραφία .png όσο και το xml αρχείο από όπου προήλθαν)

+ Ο φάκελος utils περιέχει βοηθητικά προγράμματα python που παρήγαγαν αυτόματα ορισμένα queries