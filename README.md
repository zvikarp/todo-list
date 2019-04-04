# To-do list

A to-do list app for a mini-marathon project ☑️.

## About

A simple to-do list app with a few extra functionalities:

- Can select a to-do location and be notified when near by.
- Saved on local database and backed-up to online database.

**Platform Support:** Android only.

## User Management

(Needed for the online database).

Used `google sign-in` via `firebase auth` for the following reasons:

- It is secure, as long as google trusts its own auth system and we don’t have anything to hide from them.
- It is simple, easy to setup, no need to deal with backend code.
- It is robust, come-on, its google.

## Local Database

### Platform

I used `sqlite`. There is a great package for it and it a very common database solution in the general industry.

### Security

The database is NOT encrypted or protected 😲. Although it’s important to note that the database sits on the users device and there isn’t any secure data that needs to be saved on it.

## Online Database

### Platform

Because we are using firebase auth, it would wouldn’t make sense not to use firebases `cloud firestore`, you could argue that the real time database would be more cost effective, but for the size of this project - it really doesn’t matter.

### Security

Although firestore is still in beta, there are big companies, including google itself, that use firestore. I wrote very simple security rules for this project: Every user can write and read from his to-dos collection. It’s true that he can write as much as he wants, read from the database as many time as he wants and can create as many account as he wants.

## UI

Got some inspiration from google tasks app. I didn’t focus to much on the design although I wanted it to look ok. I'm also a bit colorblind 😵 .

## Install

Ok, it’s not that simple.

There is a google maps api key that is missing and the firebase confing file is missing too.

So how to get it installed? you can ask me to sent you the apk or do it by yourself:

1. Clone [this repo](https://github.com/ZviKarp/todo-list).
2. Get a google maps api key and put it in `android/app/src/main/AndroidManifest.xml` where it says `"MY_API_KEY"`.
3. create a firebase project and follow their instructions on how to setup an android app. (you can just save the `google-services.json` file they give you).

Note: the google maps api key would be pushed if you commit it. The firebase setting wont because its in `.gitignore`.

If you don't have Flutter and don't want to install it, you can to the steps above in github and use [CodeMagic](https://codemagic.io) to create a app.


🍌
