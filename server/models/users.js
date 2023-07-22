const mongoose = require('mongoose');
const userSchema = mongoose.Schema(
{
    name:{
         required: true,
         type: 'string',
         trim: true,
         },
    email: {
           required: true,
           type: 'string',
           trim: true,
           validate:{
                   validator:(value)=>{
                   const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                   return value.match(re);
                    },
                    messages: 'Please enter a valid email address',
                  },
           },
    password: {
              required: true,
              type: 'string',
              },
    address: {
             type: 'string',
             default:'',
             },
    type: {
           type: 'string',
           default:'user',
            },
});

const User=mongoose.model('User',userSchema);
module.exports = User;

