# Cadu

## The task manager for a modern personal assistant



<a name="installation"></a>
## Installation

### What you need

- Cadu was written and tested with Ruby 2.3.1, but may or may not run on versions higher or lower than this... YMMV
- This project may or may not work on Windows, but it should be expected to run on Linux or macOS (these instructions are for macOS/Linux)
- In addition to Ruby, you need to have bundler installed (`gem install bundler`)

### Download the project

Clone the repository:

```
$ git clone https://github.com/kjleitz/cadu
```

Enter the directory and install dependencies with bundler:

```
$ cd cadu
$ bundle install
```

### Setting up client and assistant accounts

You must create a file called `roles.yml` in the `/config` directory:

```
$ touch config/roles.yml
```

Open this file and edit it to set permissions for your users **before** they create accounts. For example, if you are the site administrator and you have two assistants (Jess and John) who want to start accepting clients, you might construct a `roles.yml` file like this:

```yaml
# /config/roles.yml

you@example.com: admin
jess@example.com: assistant
john@example.com: assistant
```

Each line should be in the format `<email>: <role>`. You may add lines to this file if you need to add more non-client users later.

If someone has already created an account and they need to be made an assistant or an administrator, the only way to set their role is through the rails console. Instructions for this can be found [here](#setting_role), but it is recommended to set the role in `roles.yml` **before** account creation instead.

### Setting up the database

Run the following commands to set up a clean database (these may take a few seconds):

```
$ rake db:drop
$ rake db:migrate
```

#### Setting up a dummy database

**IMPORTANT: Only follow this subsection (_"Setting up a dummy database"_) if you want to create dummy data so you can test the application. If you do this with a production database you may lose/alter existing data, or cause bugs.** 

Add the following to your `/config/roles.yml` file:

```yaml
# /config/roles.yml

assistant@test.com: assistant
alice@telamericorp.net: assistant
ders@gmail.com: assistant
admin@test.com: admin
```

Now, run the following commands (these may take a few seconds):

```
$ rake db:drop
$ rake db:migrate
$ rake db:seed
```

Now, proceed with the rest of the instructions. Logging in with dummy data is easy:

- If you want to log into an assistant account, try logging in with the email `alice@telamericorp.net`, password `imtheboss`. Or, try `ders@gmail.com`, password `p@ssw0rd`
- To try out a blank assistant acount, sign up with the email `assistant@test.com`
- If you want to try out a client account, use `adam@yahoo.com` or `blake@hotmail.com` (both passwords are `password`)
- To try out an administrator account, sign up with the email `admin@test.com`

### Setting up Facebook login

Go to `https://developers.facebook.com/apps`. You may need to set up a developer account if you haven't already. Click the "Add a New App" button. Fill in the name of the app ("Cadu" or whatever you want), your email address, and the category "Productivity". Then, submit the form.

In the left sidebar, click "Add Product", and then hit "Get Started" on Facebook Login. On the Settings page for Facebook Login, add `http://localhost:3000/auth/facebook/callback` to the input box for "Valid OAuth redirect URIs", then hit "Save Changes" int he bottom right.

In the main app's Settings page (the link underneath "Dashboard"), add `localhost` to the input box for "App Domains". Then, in the input box for "Site URL", add `http://localhost:3000/`.

### Starting the server

Finally, start the server:

```
$ rails s
```

Navigate to `http://locahost:3000` and you can begin using Cadu!

## How to use Cadu



## Contributing

Bug reports and pull requests for this project are welcome at its [GitHub page](https://github.com/kjleitz/cadu). If you choose to contribute, please adhere to the [Ruby Community Conduct Guideline](https://www.ruby-lang.org/en/conduct/) so I don't have to go around breaking necks, running out of bubblegum, etc. If you'd like to make a suggestion for new features, make them in the "Issues" section and I'll try to get around to implementing them.

## License

This project is open source, under the terms of the [MIT license](https://opensource.org/licenses/MIT).