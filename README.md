# NYNetwork
在AFNetworking(3.x)的基础上，将请求封装成类。同时对请求回调进行统一处理，如强制下线等。

模仿了YTKNetwork，但是由于其使用的AFNetworking版本是2.6.3，支持IPV6，但核心使用的不是3.x版本的AFURLSessionManager，于是自己封装了一下。
支持在分类中修改请求回调中统一处理的方法，如强制下线等。
