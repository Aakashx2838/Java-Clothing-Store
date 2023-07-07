<%@ page import="com.mephx.DAO.interfaces.ProductDAO" %>
<%@ page import="com.mephx.DAO.implementations.ProductDAOImpl" %>
<%@ page import="com.mephx.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>


<div class="py-[30px] space-y-8 w-full">
  <div class="flex justify-between items-center">
    <h1 class="text-[36px] font-bold text-white">
      <%= request.getParameter("title") %>
    </h1>
    <a
            href="<%=request.getContextPath()%>/client/catalog.jsp?<%=request.getParameter("filter_slug")%>"
            class="text-brand font-medium underline underline-offset-4"
    >See all</a
    >
  </div>
  <div
          class="flex space-x-4 h-[380px] overflow-hidden overflow-x-scroll hide-scrollbar w-full"
  >
    <%
      ProductDAO productDAO = new ProductDAOImpl();
      List<Product> products = null;
      try {
        products = productDAO.getAllProducts("", "", "8", request.getParameter("section-filter"), request.getParameter("filter-id"), false );
      } catch (SQLException | ClassNotFoundException e) {
        throw new RuntimeException(e);
      }
      if (products != null) {
        for (Product product : products) {
      %>
      <jsp:include page="ui/recommendation-product-card.jsp">
        <jsp:param name="product_name" value="<%=product.getName()%>"/>
        <jsp:param name="brand_id" value="<%=product.getBrand().getId()%>"/>
        <jsp:param name="brand_name" value="<%=product.getBrand().getName()%>"/>
        <jsp:param name="product_link_slug" value="<%=product.getId()%>"/>
        <jsp:param name="product_rating" value="<%=product.getRating()%>"/>
        <jsp:param name="product_image_url" value="<%=product.getImagesArray()[0]%>"/>
        <jsp:param name="product_brand_image_url" value="<%=product.getBrand().getImage()%>"/>
      </jsp:include>
      <%
          }
      } else {
    %>
    <div class="text-white">No products found</div>
    <%
      }
    %>
  </div>
</div>