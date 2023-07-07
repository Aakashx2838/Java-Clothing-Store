<%@ page import="com.mephx.DAO.interfaces.ProductDAO" %>
<%@ page import="com.mephx.DAO.implementations.ProductDAOImpl" %>
<%@ page import="com.mephx.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<div class="space-y-8 w-full">
    <!-- card -->
    <div
        class=""
        style="display: grid; gap: 26px; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));"
    >
        <%
            ProductDAO productDAO = new ProductDAOImpl();
            List<Product> products = null;
            String filterId = "";
            String listBy = "";
            try {
                if (!request.getParameter("brandId").isBlank()){
                    filterId = request.getParameter("brandId");
                    listBy= "brand";
                }
                if (!request.getParameter("categoryId").isBlank()){
                    filterId = request.getParameter("categoryId");
                    listBy= "category";
                }
                if (!request.getParameter("filterType").isBlank()){
                    filterId = "" ;
                    listBy= request.getParameter("filterType");
                }
                if (!request.getParameter("listBy").isBlank()){
                    filterId = request.getParameter("listBy");
                    listBy= request.getParameter("listBy");
                }
            } catch (Exception e) {
                filterId = null;
            }

            try {
                products = productDAO.getAllProducts("", "", "", listBy , String.valueOf(filterId), false);
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
            if (products != null) {
                for (Product product : products) {
        %>
        <jsp:include page="product-list-card.jsp">
            <jsp:param name="product_name" value="<%=product.getName()%>"/>
            <jsp:param name="product_category" value="<%=product.getCategory().getName()%>"/>
            <jsp:param name="product_price" value="<%=product.getPrice()%>"/>
            <jsp:param name="brand_name" value="<%=product.getBrand().getName()%>"/>
            <jsp:param name="product_link_slug" value="<%=product.getId()%>"/>
            <jsp:param name="product_rating" value="<%=product.getRating()%>"/>
            <jsp:param name="product_image_url" value="<%=product.getImagesArray()[0]%>"/>
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