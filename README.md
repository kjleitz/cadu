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

Here you can see your "App ID" and your "App secret" (which is revealed by clicking "Show"). These will come in handy later.

### Setting up Google login

Go to `https://console.developers.google.com`. You may need to set up a developer account if you haven't already. Click the dropdown next to the Google APIs logo and select "Create project". Enter a name for your project, agree to the terms of service, and submit the form.

Use the API search box to search "contacts", then select "Contacts API". Click the "Enable" button. Once it has been enabled, hit the left arrow link next to "Contacts API" to go back.

Use the API search box again to search "google+", then select "Google+ API". Click the "Enable" button. Once it has been enabled, hit the left arrow link next to "Contacts API" to go back.

Click the "Credentials" link in the left sidebar. Click the "OAuth consent screen" tab link and fill in the product name with "Cadu" or whatever you choose, the homepage URL with `http://localhost:3000`, and then hit save.

Now, click "Create credentials" and select "OAuth client ID". Fill in the "Authorized redirect URIs" input box with `http://localhost:3000/auth/google_oauth2/callback` and hit save.

By clicking on your app's OAuth client ID name in the displayed list, you can see the "Client ID" and "Client secret". Those will come in handy later.

### Starting the server

In a new terminal window, run the following commands, substituting for the keys/secrets found in the Facebook/Google developer consoles discussed previously:

```
$ export FACEBOOK_KEY=<App ID from Facebook>
$ export FACEBOOK_SECRET=<App secret from Facebook>
$ export GOOGLE_CLIENT_ID=<Client ID from Google>
$ export GOOGLE_CLIENT_SECRET=<Client secret from Facebook>
```

Finally, start the server:

```
$ rails s
```

Navigate to `http://locahost:3000` and you can begin using Cadu!

## How to use Cadu

### As a client

#### Account creation

Once you have navigated to the site, you will be redirected to a login page, unless you are already logged in. Either log in to an existing account, sign up with your email address (the form can be accessed by clicking "Sign up" in the top navigation bar), or log in with Facebook or Google. If you log in with Facebook or Google, you will be redirected to a page where you can edit your profile and select an assistant from a drop-down list. Whether you choose an assistant from the signup page or the edit page, you must do so before you proceed.

#### Navigation

Click the "Tasks" link in the top bar to see your task list. You can create new tasks with the form at the top of the page, and you can view your existing tasks (ordered by next due) below.

Click the "Labels" link in the top bar to see a list of all the existing labels available to you, and you can click them to view all the tasks you have created that fall under that label. You can also click "Add a new label" to create a new one and associate it with existing tasks.

Click the "My profile" link in the top bar to see your user information, including your name, email, and assigned assistant. You can click the "Edit" link to edit your information, or "Users" to find your assistant's profile. 

Click the "Log out" link in the top bar to log out.

#### Tasks

You can create a task by clicking the "Tasks" link in the top bar, and then filling out the form at the top of the page. A task requires a title, contents, and a due date. The due date defaults to two hours in the future. You can select existing labels from the scrollable box on the right, and you can select (or deselect) individual labels with cmd+click (on macOS) or ctrl+click (on Windows). You can also type labels as a comma-separated list in the input box below the scrollable box, and it will create new labels or use existing ones when they are found.

Once you create a task, you will be brought to the individual viewing page for that task. You can write comments here, which will be shared between only your assistant and yourself (as long as you have requested assistance on the task). This is a good area for discussing the task, should it need extra information. You will receive a notification if your assistant comments on one of your tasks. 

You can edit the task if you click the "Edit" tab. Here you can change the title, the contents, the due date, and the labels.

To return to the task index, you can either click the "Summary" tab (which will keep you scrolled to the position of the task in the main list) or click the "Tasks" link in the top bar. Here, there is a list of your tasks. If you click the "Request Assistance" button on any task, it will allow your assistant to view the task, accept the request, mark it as "in progress", and mark it complete. You will be notified of each of these events (with a notification), and you can also track the progress of each task by checking the circles at the top right of each task card:

- `(...) (   ) (   )` - task has been requested, but your assistant has not yet accepted it
- `(yellow) (   ) (   )` - task has been accepted
- `(yellow) (blue) (   )` - task has been started
- `(yellow) (blue) (green)` - task has been completed

You can also mark a task complete if you have completed it yourself, and you can remove a task which has already been marked complete. You will see that the buttons at the bottom will change based on what you can do with the task at the moment.

#### Labels

You can view all tasks associated with a particular label either by clicking a label link underneath a task's title, or by clicking the "Labels" link in the top bar and selecting the label for which you would like to view associated tasks. Either action will yield a list of task cards much like your main task list, only restricted to those which fall under the label you have selected.

You can create a new label by clicking the "Labels" link in the top bar, then clicking "Add a new label" under the heading. Here, you can fill in a new label name, and select existing tasks from your task list to associate with that label (optional).

#### Notifications

On the left side of the screen, you can see your notifications. These will be sent to you whenever something notable happens regarding a particular task of yours (e.g. a task assistance request has been accepted by your assistant, a task has been completed, etc.). They are colored according to the status of the task they are related to (yellow: accepted, blue: in progress, green: completed), and you can click them to view the task and its comments in full. After you click a notification, it moves to the bottom of the new notifications, turns gray, becomes italicized, and is marked with _(seen)_.

#### Reminders

On the right side of the screen, you can see your reminders. These are sent to you by your assistant, and they may or may not be associated with a task. If they are, there will be a link to that particular task, colored according to the status of the task (light gray: requested, yellow: accepted, blue: in progress, green: completed). You can dismiss a reminder you've seen by clicking the red "Dismiss" button, which will remove it from the "New" list. You can view dismissed reminders if you click the "Dismissed" tab (the content will be italicized).

### As an assistant



## Contributing

Bug reports and pull requests for this project are welcome at its [GitHub page](https://github.com/kjleitz/cadu). If you choose to contribute, please adhere to the [Ruby Community Conduct Guideline](https://www.ruby-lang.org/en/conduct/) so I don't have to go around breaking necks, running out of bubblegum, etc. If you'd like to make a suggestion for new features, make them in the "Issues" section and I'll try to get around to implementing them.

## License

This project is open source, under the terms of the [MIT license](https://opensource.org/licenses/MIT).