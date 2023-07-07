<%@ page import="com.mephx.DAO.interfaces.CategoryDAO" %>
<%@ page import="com.mephx.DAO.implementations.CategoryDAOImpl" %>
<%@ page import="com.mephx.DAO.interfaces.BrandDAO" %>
<%@ page import="com.mephx.DAO.implementations.BrandDAOImpl" %>
<%@ page import="com.mephx.model.Category" %>
<%@ page import="com.mephx.model.Brand" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Objects" %>
<form class="max-w-[245px] w-full bg-bg h-[1218px] text-white mt-[56px]" method="post" action="catalog.jsp">
  <%
    ArrayList<Category> categories = null;
    ArrayList<Brand> brands = null;
    boolean isDataLoaded = false;
    CategoryDAO categoryDAO = new CategoryDAOImpl();
    BrandDAO brandDAO = new BrandDAOImpl();
    try{
      categories = categoryDAO.getAllCategories(false);
      brands = brandDAO.getAllBrands(false);
      if (categories != null && brands != null) {
        isDataLoaded = true;
      }
    } catch (SQLException | ClassNotFoundException e) {
      throw new RuntimeException(e);
    }
  %>
  <div class="flex border-b-white">
    <h1 class="text-neutral-300 text-[20px] mb-4">Filter Product</h1>
    <i
      class="fa-regular fa-sliders-up ml-auto mt-2"
      style="color: #c9c9c9"
    ></i>
    <i
      class="fa-regular fa-sliders-up fa-rotate-180"
      style="color: #868e96"
    ></i>
  </div>
  <hr class="opacity-25 m-auto" />
  <div class="disclosure flex flex-col justify-between p-4">
    <div class="flex flex-row justify-between space-y-2">
      <button
        class="relative flex flex-row justify-between w-full text-[14px]"
      >
        <input
          type="checkbox"
          name="disclosure"
          class="disclosure-button absolute inset-0 opacity-0 text-neutral-400"
        />
        Brand
        <i class="fa-solid fa-chevron-down" style="color: #c9c9c9"></i>
      </button>
    </div>
    <div class="space-y-2">
      <div class="disclosure-next-data h-0 overflow-hidden space-y-2 pt-2">
        <%
          if (isDataLoaded){
            for (Brand brand : brands) {
        %>
        <div>
          <input
            type="radio"
            id="<%=brand.getName()%>"
            class="largerCheckbox"
            name="brandId"
            value="<%=brand.getId()%>"
            <%
              if (request.getParameter("brandId") != null) {
                if(Integer.parseInt(request.getParameter("brandId")) == brand.getId()) {
            %>
                checked
            <%
                }
              }
            %>
          />
          <label for="<%=brand.getName()%>" class="ml-3"><%=brand.getName()%></label>
        </div>
        <%
            }
          }
        %>
      </div>
    </div>
  </div>
  <hr class="opacity-25 m-auto" />
  <div class="disclosure flex flex-col justify-between p-4">
    <div class="flex flex-row justify-between space-y-2">
      <button
        class="relative flex flex-row justify-between w-full text-[14px]"
      >
        <input
          type="checkbox"
          name="disclosure"
          class="disclosure-button absolute inset-0 opacity-0 text-neutral-400"
        />
        Category
        <i class="fa-solid fa-chevron-down" style="color: #c9c9c9"></i>
      </button>
    </div>
    <div class="space-y-2">
      <div class="disclosure-next-data h-0 overflow-hidden space-y-2 pt-2">
        <%
          if (isDataLoaded){
            for (Category category : categories) {
        %>
        <div>
          <input
            type="radio"
            id="<%=category.getName()%>"
            class="largerCheckbox"
            name="categoryId"
            value="<%=category.getId()%>"
            <%
              if (request.getParameter("categoryId") != null) {
                if(Integer.parseInt(request.getParameter("categoryId")) == category.getId()) {
            %>
            checked
            <%
                }
              }
            %>
          />
          <label for="<%=category.getName()%>" class="ml-3"><%=category.getName()%></label>
        </div>
        <%
            }
          }
        %>
      </div>
    </div>
  </div>
  <hr class="opacity-25 m-auto" />
  <div class="disclosure flex flex-col justify-between p-4">
    <div class="flex flex-row justify-between space-y-2">
        <select name="listBy" class="flex flex-row border-2 border-slate-800 rounded-md p-1 w-full !text-black">
            <option value="" disabled <%=request.getParameter("listBy") == null ? "selected" : "" %>>--Select Sorting Option--</option>
            <option value="new" <%=Objects.equals(request.getParameter("listBy"), "new") ? "selected" :  "" %> >Newest</option>
            <option value="popular" <%=Objects.equals(request.getParameter("listBy"), "popular") ? "selected" :  "" %>>Popular</option>
            <option value="priceHL" <%=Objects.equals(request.getParameter("listBy"), "priceHL") ? "selected" :  "" %>>Price: High to Low</option>
            <option value="priceLH" <%=Objects.equals(request.getParameter("listBy"), "priceLH") ? "selected" :  "" %>>Price: Low to High</option>
            <option value="random" <%=Objects.equals(request.getParameter("listBy"), "random") ? "selected" :  "" %>>Surprise Me!</option>
        </select>
    </div>
  </div>
  <div>
    <button type="submit" class="btn-primary w-full">
      Apply Filter
    </button>
  </div>
</form>