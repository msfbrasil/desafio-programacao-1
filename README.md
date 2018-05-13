# Hello there!

This little peace of code was built using ruby 2.3.1 and rails 5.2.0.

For that reason, those guys are, therefore, expected to be considered as dependencies to validate the current implementation.

After having both installed and configured, we need to install a dependency of "ruby-filemagic" gem used on project through the command:

sudo apt-get install libmagic-dev

Only after that, we can execute the further steps to get this application up and running throug the execution of following commands:

$ bundle install

and

$ rake db:migrate

Now, we can use "rails server" to test the application.

Notes:

1- I've provided only one unit test that could be found under "<APP_FOLDER>/test/helpers/sale_record_file_parser_test.rb", which can be tested through command:

rails test test/helpers/sale_record_file_parser_test.rb

2- Testing files can be found at folder: "test/resources/". Some with different extensions to fall into mime verification and some variations of the example file with wrong number of columns and invalid data.

ENJOY!


