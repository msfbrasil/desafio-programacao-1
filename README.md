# Rails Challenge

## Details

This little peace of code was built using ruby 2.3.1 and rails 5.2.0.

For that reason, those guys are, therefore, expected to be considered as dependencies to validate the current implementation.

## Dependencies

First of all, we need to install a dependency of "ruby-filemagic" gem used on project through the command:

sudo apt-get install libmagic-dev

The application must be started with SSL support, which is mandatory now for Facebook authentication delegation. Because of that, the openssl package must be installed through the following commands:

Important: it's advisable to uninstall "puma" gem before installing openssl packages, and reinstall it right after. Honestly this was a recomendation I've found on a site with instructions to start the server with SSL. I folowed the instructions and had no problems. I don't know if the uninstall/install procedure of "puma" gem is really necessary.

sudo apt-get install openssl
sudo apt-get install libssl-dev

## Preparing to run

Now we can execute the further steps to get this application up and running throug the execution of following commands:

$ bundle install

and

$ rake db:migrate

After all that, we can finally start the server using the command: 

rails server -b 'ssl://localhost:3000?key=.ssl/localhost.key&cert=.ssl/localhost.crt'

## Notes:

1- If some problem happens while starting the server with command above, try to uninstall "puma" gem and install it again.

2- I've provided only one unit test that could be found under "<APP_FOLDER>/test/helpers/sale_record_file_parser_test.rb", which can be tested through command:

rails test test/helpers/sale_record_file_parser_test.rb

3- Testing files can be found at folder: "test/resources/". Some with different extensions to fall into mime verification and some variations of the example file with wrong number of columns and invalid data.

ENJOY!


