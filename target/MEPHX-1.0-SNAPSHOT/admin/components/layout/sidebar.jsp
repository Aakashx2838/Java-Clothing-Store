<div class="bg-neutral-700 flex max-w-xs w-full min-h-screen h-full flex-col justify-between p-10 gap-4 text-white">
    <div class="w-full h-96 flex flex-col justify-between">
        <a href="<%=request.getContextPath()%>/admin/index.jsp">
            <div class="flex hover:text-brand">
                <div class="my-auto mr-2">
                    <i class="fa-solid fa-house"></i>
                </div>
                <div >
                    Dashboard
                </div>
            </div>
        </a>
        <div class="bg-neutral-400 w-full border-t-2"></div>
        <a href="<%=request.getContextPath()%>/admin/manage-product.jsp">
            <div class="flex hover:text-brand">
                <div class="my-auto mr-2">
                    <i class="fa-solid fa-bars-progress"></i>
                </div>
                <div>
                    Manage Product
                </div>
            </div>
        </a>
        <a href="<%=request.getContextPath()%>/admin/manage-category.jsp">
            <div class="flex hover:text-brand">
                <div class="my-auto mr-2">
                    <i class="fa-solid fa-bars-progress"></i>
                </div>
                <div>
                    Manage Catagory
                </div>
            </div>
        </a>
        <a href="<%=request.getContextPath()%>/admin/manage-brand.jsp">
            <div class="flex hover:text-brand">
                <div class="my-auto mr-2">
                    <i class="fa-solid fa-bars-progress"></i>
                </div>
                <div>
                    Manage Brand
                </div>
            </div>
        </a>
        <div class="bg-neutral-400 w-full border-t-2 rounded-full"></div>
        <a href="<%=request.getContextPath()%>/admin/add-product.jsp">
            <div class="flex hover:text-brand">
                <div class="my-auto mr-2">
                    <i class="fa-solid fa-square-plus"></i>
                </div>
                <div>
                    Add Product
                </div>
            </div>
        </a>
        <a href="<%=request.getContextPath()%>/admin/add-category-brand.jsp">
            <div class="flex hover:text-brand">
                <div class="my-auto mr-2">
                    <i class="fa-solid fa-clipboard-list"></i>
                </div>
                <div>
                    Add Brand & Category
                </div>
            </div>
        </a>
        <div class="bg-neutral-400 w-full border-t-2"></div>

        <a href="<%=request.getContextPath()%>/admin/view-order.jsp">
            <div class="flex hover:text-brand">
                <div class="my-auto mr-2">
                    <i class="fa-solid fa-cart-shopping"></i>
                </div>
                <div>
                    Order
                </div>
            </div>
        </a>
    </div>
</div>