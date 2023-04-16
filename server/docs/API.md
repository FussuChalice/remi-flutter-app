# API methods
|           Path           | Description | Method |            Data            |
|:------------------------:|:-----------:|:------:|:--------------------------:|
|     /api/auth/signup     |    SignUp   |  POST  | JsonBody {email, password} |
|      /api/auth/login     |    LogIn    |  POST  | JsonBody {email, password} |
| /api/utility/uuid_to_id/ |  UUID => ID |   GET  |       JsonBody {uuid}      |
| /api/data/*/:id |  GET * = ['settings', 'promocodes', 'contacts', 'comments', 'images', 'menu', 'orders', 'main_image',] data , :id = user id  | GET |      Null      |
| /dev/version |  Get app version |   GET  |       Null      |
