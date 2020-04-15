#POM父项目，对Maven项目进行统一管理

#Host配置
127.0.0.1 gimp-discovery gimp-api-gateway gimp-config-server

#主机规划：
- gimp-discovery		8047	注册中心			http://gimp-discovery:8047/
- gimp-conf-server		8048	配置服务			http://127.0.0.1:8048/
- gimp-auth-server	        8049	授权认证服务		http://127.0.0.1:8049/
- gimp-api-gateway	        8050	API访问网关		http://127.0.0.1:8050/
- gimp-module-sys		8051	系统服务提供者		http://127.0.0.1:8051/
- gimp-module-workflow		8052	工作流服务提供者		http://127.0.0.1:8052/
- gimp-resource-server	8053	静态文件资源服务器	http://127.0.0.1:8053/
- gimp-module-extend		8054扩展模块，如其他的小服务	http://127.0.0.1:8054/
- gimp-web			9000	页面访问地址		http://127.0.0.1:9000/

#说明
- 如需引用某个子项目，需要将子项目安装到本地库，安装命令如下:mvn deploy
- 命令行运行程序：
    - 1. 进入项目根目录，执行命令：mvn clean package
    - 2. 生成jar包后，执行命令：java -jar -Xms256m -Xmx512m target/XXXX.jar