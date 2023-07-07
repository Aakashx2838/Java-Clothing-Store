<div
        class="min-w-[320px] h-[375px] relative overflow-hidden"
        id="home-product-suggestion-card"
>
  <img
          src="<%= request.getContextPath() + request.getParameter("product_image_url") %>"
          alt="product"
          class="w-full h-full object-cover rounded-md"
          loading="lazy"
  />
  <div
          class="absolute left-0 bottom-0 bg-black/25 backdrop-blur-2xl w-full p-4 text-white space-y-[12px] translate-y-[500px] transition-all duration-500 ease-in-out"
          id="home-product-suggestion-card-content"
  >
    <div class="flex justify-between items-center">
      <div class="flex items-center space-x-4">
        <img
                loading="lazy"
                src="<%= request.getContextPath() + request.getParameter("product_brand_image_url") %>"
                class="h-[36px] aspect-square object-contain"
                alt=""
        />
        <a href="<%=request.getContextPath()%>/client/catalog.jsp?brandId=<%=request.getParameter("brand_id")%>" class="font-medium text-[18px]"><%=request.getParameter("brand_name")%></a>
      </div>
      <div class="text-[20px]">
        <span><%=request.getParameter("product_rating")%></span>
        <i class="fa-solid fa-star text-yellow-500"></i>
      </div>
    </div>
    <div>
      <a href="<%=request.getContextPath() + "/client/product.jsp?productId="+request.getParameter("product_link_slug")%>" class="text-[28px] font-semibold line-clamp-1"
      ><%=request.getParameter("product_name")%>
      </a>
    </div>
    <a href="<%=request.getContextPath() + "/client/product.jsp?productId="+request.getParameter("product_link_slug")%>" class="btn-tertiary !max-w-full rounded-full block">
      Buy
    </a>
  </div>
</div>