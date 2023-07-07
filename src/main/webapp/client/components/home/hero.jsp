<%@ page import="com.mephx.DAO.interfaces.ProductDAO" %>
<%@ page import="com.mephx.DAO.implementations.ProductDAOImpl" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.mephx.model.Product" %>
<div class="relative h-[425px] rounded-b-md overflow-hidden">
  <img
          class="w-full h-full object-cover filter brightness-50"
          src="<%= request.getContextPath() %>/assets/test/hero.jpg"
          alt="hero"
          loading="lazy"
  />
  <div class="absolute inset-0 flex items-center justify-between p-8">
    <!-- Hero-Text -->
    <div class="max-w-[390px]">
      <h1 class="text-[48px] font-bold text-white">
        All the best cool outfits on
        <span class="text-brand">MEPHX</span>
      </h1>
      <p class="text-[20px] text-text-dim font-normal">
        Explore high quality products from your favourite
        animes.
      </p>
      <a
              href="<%=request.getContextPath()%>/client/catalog.jsp"
              class="btn-primary max-w-[175px] w-full mt-8 !border-brand !text-black block"
      >
        Explore
      </a>
    </div>
    <!-- Hero-Featured-Cards -->
    <%
      ProductDAO productDAO = new ProductDAOImpl();
      ArrayList<Product> products = null;
      try {
        products = productDAO.getAllProducts("","","3","random", "", false );
      } catch (SQLException | ClassNotFoundException e) {
        throw new RuntimeException(e);
      }
    %>

    <%
      if (products != null && products.size() == 3) {
    %>
    <div class="relative max-w-[500px] w-full h-full">
      <div
              class="bg-bg-light min-h-[310px] h-fit w-[245px] rounded-md p-[12px] space-y-[12px] text-center absolute z-30 transform translate-x-[150px] translate-y-[50px] rotate-[20deg] shadow-black shadow-2xl hover:z-[100] transition-all duration-300 ease-in"
      >
        <img
                src="<%= request.getContextPath() %>/<%=products.get(0).getImagesArray()[0]%>"
                alt="product"
                class="h-[175px] w-full rounded-md object-cover"
        />
        <h1 class="text-[20px] font-semibold text-white line-clamp-1"><%=products.get(0).getName()%></h1>
        <p class="text-text-dim font-normal text-[14px]">
          <%=products.get(0).getBrand().getName()%>
        </p>
        <div class="flex items-center justify-center w-full">
          <a class="btn-tertiary block" href="<%=request.getContextPath()%>/client/product.jsp?productId=<%=products.get(0).getId()%>">Buy</a>
        </div>
      </div>
      <div
              class="bg-bg-light min-h-[310px] h-fit w-[245px] rounded-md p-[12px] space-y-[12px] text-center absolute z-50 shadow-black shadow-2xl hover:z-[100] transition-all duration-300 ease-in"
      >
        <img
                src="<%= request.getContextPath() %>/<%=products.get(1).getImagesArray()[0]%>"
                alt="product"
                class="h-[175px] w-full rounded-md object-cover"
        />
        <h1 class="text-[20px] font-semibold text-white line-clamp-1"><%=products.get(1).getName()%></h1>
        <p class="text-text-dim font-normal text-[14px]">
          <%=products.get(1).getBrand().getName()%>
        </p>
        <div class="flex items-center justify-center w-full">
          <a class="btn-tertiary block" href="<%=request.getContextPath()%>/client/product.jsp?productId=<%=products.get(1).getId()%>">Buy</a>
        </div>
      </div>
      <div
              class="bg-bg-light min-h-[310px] h-fit w-[245px] rounded-md p-[12px] space-y-[12px] text-center absolute z-30 transform -translate-x-[150px] translate-y-[50px] rotate-[-20deg] shadow-black shadow-2xl hover:z-[100] transition-all duration-300 ease-in"
      >
        <img
                src="<%= request.getContextPath() %>/<%=products.get(2).getImagesArray()[0]%>"
                alt="product"
                class="h-[175px] w-full rounded-md object-cover"
        />
        <h1 class="text-[20px] font-semibold text-white line-clamp-1"><%=products.get(2).getName()%></h1>
        <p class="text-text-dim font-normal text-[14px]">
          <%=products.get(2).getBrand().getName()%>
        </p>
        <div class="flex items-center justify-center w-full">
          <a class="btn-tertiary block" href="<%=request.getContextPath()%>/client/product.jsp?productId=<%=products.get(2).getId()%>">Buy</a>
        </div>
      </div>
    </div>
    <%
      }
    %>
  </div>
</div>