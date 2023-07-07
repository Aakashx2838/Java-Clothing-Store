<%@ page import="com.mephx.model.Category" %>
<%@ page import="com.mephx.DAO.interfaces.CategoryDAO" %>
<%@ page import="com.mephx.DAO.implementations.CategoryDAOImpl" %>
<%@ page import="java.util.List" %>
<%
  CategoryDAO categoryDAO = new CategoryDAOImpl();
  List<Category> categories = null;
  Boolean isDataLoaded = false;
  try{
    categories = categoryDAO.getAllCategories(false);
    if (categories != null) {
      isDataLoaded = true;
    }
  } catch (SQLException | ClassNotFoundException e) {
    throw new RuntimeException(e);
  }
%>
<div
  class="max-w-[235px] w-full bg-gradient-to-b from-black/70 via-bg to-bg h-screen px-10 flex-shrink-0"
>
  <ul
    class="mx-auto text-text-dim font-semibold text-lg space-y-[24px] w-full py-8"
  >
    <li>
      <a href="home.jsp">
        <i class="fa-solid fa-house mr-4"></i>
        Home
      </a>
    </li>
    <li>
      <a href="cart.jsp">
        <i class="fa-solid fa-cart-shopping mr-4"></i>
        Cart
      </a>
    </li>
    <li>
      <a href="order-history.jsp">
        <i class="fa-solid fa-clock-rotate-left mr-4"></i>
        Order History
      </a>
    </li>
    <li>
      <a href="catalog.jsp">
        <i class="fa-solid fa-filter mr-4"></i>
        Catalog
      </a>
    </li>
  </ul>
  <hr class="border-neutral-700"/>
  <ul
    class="mx-auto text-text-dim font-semibold text-lg space-y-[24px] w-full py-8"
  >
    <%
      if (isDataLoaded){
        for (Category category : categories) {
    %>
    <li>
      <a class="flex items-center text-white block" href="<%=request.getContextPath()%>/client/catalog.jsp?categoryId=<%=category.getId()%>">
        <svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px"
             width="24" height="24"
             color="white"
             fill="white"
             class="mr-4"
             viewBox="0 0 50 50">
          <path d="M 19 3 A 1.0001 1.0001 0 0 0 18.921875 3.0039062 A 1.0001 1.0001 0 0 0 18.822266 3.015625 A 1.0001 1.0001 0 0 0 18.642578 3.0625 L 11.724609 5.0390625 A 1.0001 1.0001 0 0 0 11.689453 5.0507812 C 11.558088 5.0847928 8.2191394 5.9709712 6.4921875 8.8496094 C 4.0969515 12.839334 0.140625 19.488281 0.140625 19.488281 A 1.0001 1.0001 0 0 0 0.48242188 20.855469 L 7.1074219 24.855469 A 1.0001 1.0001 0 0 0 8.4726562 24.529297 L 11 20.486328 L 11 46 A 1.0001 1.0001 0 0 0 12 47 L 38 47 A 1.0001 1.0001 0 0 0 39 46 L 39 20.486328 L 41.527344 24.529297 A 1.0001 1.0001 0 0 0 42.892578 24.855469 L 49.517578 20.855469 A 1.0001 1.0001 0 0 0 49.859375 19.488281 C 49.859375 19.488281 45.90305 12.839334 43.507812 8.8496094 C 41.812536 6.0237698 38.595881 5.1293517 38.351562 5.0644531 A 1.0001 1.0001 0 0 0 38.275391 5.0390625 L 31.375 3.0683594 A 1.0001 1.0001 0 0 0 31 3 A 1.0001 1.0001 0 0 0 30.978516 3 L 25 3 L 19.021484 3 L 19 3 z M 20.355469 5 L 25 5 L 29.644531 5 C 29.517812 5.29595 29.363441 5.6113092 29.140625 5.9414062 C 28.431398 6.9921126 27.30754 8 25 8 C 22.69246 8 21.568602 6.9921126 20.859375 5.9414062 C 20.636559 5.6113092 20.482188 5.29595 20.355469 5 z M 18.324219 5.2324219 C 18.504372 5.7592001 18.756175 6.3964458 19.203125 7.0585938 C 20.181398 8.5078875 22.05754 10 25 10 C 27.94246 10 29.818602 8.5078875 30.796875 7.0585938 C 31.243825 6.3964459 31.495628 5.7592001 31.675781 5.2324219 L 36.699219 6.6679688 C 36.374187 7.5977407 36 8.9631139 36 11 C 36 14.726858 36.805241 16.682517 36.990234 17.103516 A 1.0001 1.0001 0 0 0 37 17.167969 L 37 45 L 13 45 L 13 17.169922 A 1.0001 1.0001 0 0 0 13.009766 17.105469 C 13.193986 16.686415 14 14.729565 14 11 C 14 8.9631139 13.625813 7.5977408 13.300781 6.6679688 L 18.324219 5.2324219 z M 11.427734 7.3085938 C 11.685787 8.0854999 12 9.3277281 12 11 C 12 14.769995 11.143826 16.475264 11.115234 16.53125 L 7.2988281 22.634766 L 2.3691406 19.658203 C 2.9207713 18.731365 6.0082009 13.54148 8.2070312 9.8789062 C 9.0239387 8.5172118 10.497509 7.7186947 11.427734 7.3085938 z M 38.572266 7.3085938 C 39.502492 7.7186947 40.976061 8.5172118 41.792969 9.8789062 C 43.991799 13.54148 47.079229 18.731365 47.630859 19.658203 L 42.701172 22.634766 L 38.884766 16.53125 C 38.856174 16.475264 38 14.769995 38 11 C 38 9.3277281 38.314213 8.0855 38.572266 7.3085938 z"></path>
        </svg>
        <p>
          <%=category.getName()%>
        </p>
      </a>
    </li>
    <%
        }
      }
    %>
  </ul>
</div>