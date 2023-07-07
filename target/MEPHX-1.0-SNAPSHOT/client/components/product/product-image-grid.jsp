<div class="columns-2 space-y-3 gap-3">
  <%
    for (String image : product.getImagesArray()) {
  %>
  <img
          src="<%=request.getContextPath() + image %>"
          alt="<%= product.getName() %> image"
          class="max-w-[350px]"
          loading="lazy"

  />
  <%
    }
  %>
</div>