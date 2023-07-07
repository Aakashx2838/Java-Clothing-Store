<%@ page import="com.mephx.DAO.interfaces.BrandDAO" %>
<%@ page import="com.mephx.DAO.implementations.BrandDAOImpl" %>
<%@ page import="com.mephx.model.Brand" %>
<div class="w-full flex">
  <%!
    ArrayList<Brand> brands = null;
  %>
  <div class="mx-auto flex space-x-8 py-5">
  <%
    BrandDAO brandDAO = new BrandDAOImpl();
    try {
        brands = brandDAO.getAllBrands(false);
    }catch (SQLException | ClassNotFoundException e) {
        out.print("Error fetching brands");
    }
  %>
  <%
    if (brands != null) {
      for (Brand brand : brands) {
  %>
  <img
          src="<%= request.getContextPath() %><%= brand.getImage() %>"
          alt="<%= brand.getName() %> logo"
          class="w-[150px] aspect-square object-contain"
          loading="lazy"
  />
  <%
      }
    }
  %>
  </div>
</div>