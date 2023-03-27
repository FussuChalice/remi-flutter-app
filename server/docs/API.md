# API methods
|           Path           | Description | Method |            Data            |
|:------------------------:|:-----------:|:------:|:--------------------------:|
|     /api/auth/signup     |    SignUp   |  POST  | JsonBody {email, password} |
|      /api/auth/login     |    LogIn    |  POST  | JsonBody {email, password} |
| /api/utility/uuid_to_id/ |  UUID => ID |   GET  |       JsonBody {uuid}      |