# Photowall

**This site was built and deployed using:** 
* Ruby on Rails
* PostgreSQL
* Vue.js
* AWS S3
* Carrierwave
* Rspec
* Fog
* Factory Bot
* Heroku

# Running the program locally

## Basic setup

To run the program locally first clone the code wherever you want the code to be stored and install all the required gems by running:
```
git clone https://github.com/markschnabel/photowall
bundle install
```
This app uses AWS S3 Buckets for image storage so you will need to have an AWS
account with your own buckets to run the app locally. You can set up an account 
here: https://aws.amazon.com/, once you've done that navigate to the console, select
S3 and follow the prompts to create a bucket. This application uses two buckets, 
one for development and another for production. If you would like to mimic this 
create two buckets.

Next, this application uses figaro for credential management. Figaro is already in
the gem file and should be installed, so if you would like to continue with this pattern
simply run:
```
figaro install
```
this will create a `config/application.yml` file and automatically append the file to
your .gitignore. Once you have done this add this to your config/application.yml file
and replace the examples with the credentials you were given when setting up your 
S3 buckets
```
AWS_ACCESS_KEY_ID: your aws access key id
AWS_SECRET_ACCESS_KEY: your aws secret access key
development:
  AWS_BUCKET: your development bucket's name
production:
  AWS_BUCKET: your production bucket's name
```

## Run Development Server

You can start the dev server by running
```
rails s
```

After that the program should now be accessible at: http://localhost:3000 on your computer.

It is also recommended to run the webpack development server alongside it if you are going to change any frontend code as it will enable hot-reloading for all frontend assets. You can do this with the following command:
```
bin/webpack-dev-server
```

## Run Tests
Running tests is as simple as navigating to the directory you've stored the code in and running 
```
bundle exec rspec
```

## License
 
The MIT License (MIT)

Copyright (c) 2019 Mark Schnabel <mark.schnabel@markschnabel.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
