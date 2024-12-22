# README

This README provides the necessary steps to get the application up and running on your local machine.

Prerequisites
Ensure you have the following installed on your machine:

- Ruby 3.3.6
- Rails 7.1
- PostgreSQL 14
- Node.js >= 20

### Setup Instructions

#### 1. Clone the Repository

```
$> git@github.com:aslam/direct_shifts.git
$> cd direct_shifts
```

#### 2. Setup the Backend (Rails API)

##### Install Ruby Gems

```
$> gem install bundler
$> bundle install
```

##### Setup the Database

Ensure PostgreSQL is running on your machine. Then, run the following command to create and setup the database:

```
bin/setup
```

#### 3. Setup the Frontend (React)

Navigate to the `frontend` directory and install the necessary Node.js packages:

```
$> cd frontend
$> npm install
```

#### 4. Running the Application

##### Start the Rails Server

In the root directory of the project, run:

```
$> bin/rails server
```

##### Start the React Development Server

In the `frontend` directory, run:

```
$> npm run dev
```

#### 5. Access the Application

Open your browser and navigate to:

`http://localhost:3001` to access the React frontend.

### Additional Information

#### Running Tests

To run the test suite, use the following command:

`bundle exec rspec`
