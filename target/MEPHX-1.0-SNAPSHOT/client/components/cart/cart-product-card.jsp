<%
  int quantity = Integer.parseInt(request.getParameter("quantity"));
%>
<div class="w-full p-6 flex  justify-between bg-neutral-800 rounded-lg">
  <div class="flex space-x-4">
    <img loading="lazy" class="w-[140px] aspect-square object-cover" src="<%=request.getContextPath()+request.getParameter("image")%>" alt="user-cart-product" />
    <div class="space-y-2">
      <p class=" font-semibold text-base ">
        <a href="<%=request.getContextPath()+"/client/product.jsp?productId="+request.getParameter("product_id")%>" class="text-white">
          <%=request.getParameter("name")%>
        </a>
      </p>
      <p class="text-neutral-400 text-[14px] ">
        Size: <span class="text-white"><%=request.getParameter("size")%></span>
      </p>
      <p class="text-neutral-400 text-[14px] ">
        Color: <span class="text-white"><%=request.getParameter("color")%></span>
      </p>
      <div class="flex items-center py-1">
        <form action="<%=request.getContextPath()%>/update-product-quantity" class="flex items-center" method="post">
          <input type="hidden" name="cart_item_id" value="<%=request.getParameter("cart_item_id")%>">
          <button class="bg-neutral-700 p-1 rounded-full aspect-square h-8" value="decrement" name="action"> - </button>
        </form>
        <form action="<%=request.getContextPath()%>/update-product-quantity" class="flex items-center" method="post">
          <input type="hidden" name="cart_item_id" value="<%=request.getParameter("cart_item_id")%>">
          <span class="w-[33px] block text-center"><%=request.getParameter("quantity")%></span>
          <button class=" bg-black p-1 rounded-full aspect-square h-8" value="increment" name="action"> + </button>
        </form>
      </div>
    </div>
  </div>

  <div class="flex flex-col justify-between">
    <form action="<%=request.getContextPath()%>/remove-from-cart" method="post">
      <input type="hidden" name="cart_item_id" value="<%=request.getParameter("cart_item_id")%>">
      <button class=" text-red-500 text-[16px] font-normal" type="submit">
        <i class="fa-solid fa-trash-alt mr-2"></i>
        <span class="underline underline-offset-4">Remove</span>
      </button>
    </form>
    <p class="text-[20px] text-right font-medium">
      NPR. <span class="text-white"><%= request.getParameter("item_total") %></span>
    </p>
  </div>
</div>