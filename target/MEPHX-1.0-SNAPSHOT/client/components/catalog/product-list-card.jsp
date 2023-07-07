<a class="w-[275px] bg-slate-800 text-white ml-[15px] rounded-lg block"
   href="<%=request.getContextPath()%>/client/product.jsp?productId=<%=request.getParameter("product_link_slug")%>">
  <img
          loading="lazy"
          class="w-full aspect-[2.5/3] object-cover rounded-lg"
          src="<%= request.getContextPath() + request.getParameter("product_image_url") %>"
          alt="card"
  />
  <div class="flex justify-between p-4 pb-2">
    <div class="space-y-[10px]">
      <p class="text-[10px] text-neutral-400"><%=request.getParameter("brand_name")%></p>
      <p class="text-[14px] font-semibold"><%=request.getParameter("product_name")%></p>
    </div>
    <div class="pt-4 pb-2">
      <i class="fa fa-star text-brand" aria-hidden="true"></i>
      <span class="ml-2 font-medium">(<%=request.getParameter("product_rating")%>)</span>
    </div>
  </div>
  <div class="flex px-4 pb-2">
    <p class="text-brand font-bold text-[12px] uppercase">
      NPR. <%=request.getParameter("product_price")%>
    </p>
  </div>
</a>