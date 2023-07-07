<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MEPHX | 404 Not Found</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/errorPages.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/globals.css" />
    <script src="https://kit.fontawesome.com/86f6b8ce70.js" crossorigin="anonymous"></script>
</head>

<body class="bg-bg font-urbanist text-neutral-200 flex h-screen ">
<div class=" m-auto mx-auto my-auto flex">
    <div class=" ">
        <div class="flex">
            <div class="h-full block">
                <span class="text-[350px] leading-[400px]">404</span>
                <br>
            </div>
        </div>

        <div class="overflow-hidden text-right">
            <h1 class="text-[25px]">DON'T BE LIKE ZORO!!</h1>
            <h1 class="font-semibold text-[30px]">Return to <a href="<%=request.getContextPath()%>/index.jsp" class="text-brand">HOME PAGE</a> now
            </h1>
        </div>
    </div>
    <div>
        <img class="w-[500px] aspect-square object-contain" src="<%=request.getContextPath()%>/assets/images/notfoundzoro.png" alt="">
    </div>
</div>
</body>

</html>


