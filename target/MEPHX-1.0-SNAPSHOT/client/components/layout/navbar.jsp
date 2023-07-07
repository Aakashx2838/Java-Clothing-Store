<div class="fixed w-full z-[9999999999]">
  <div
          class="flex bg-bg/30 backdrop-filter backdrop-blur-lg text-white py-[12px] border-b-2 border-border-dark px-5 relative"
  >
    <div class="flex mx-auto w-full justify-between max-w-[1550px]">
      <div class="flex items-center justify-center space-x-[48px]">

        <a href="<%=request.getContextPath()%>/client/home.jsp">
          <img
                  src="<%=request.getContextPath()%>/assets/images/logo/logo.png"
                  alt="logo"
                  class="h-[44px] w-full"
          />
        </a>
      </div>
      <%
        if(request.getRequestURI().contains("client") ){
      %>
      <input
          type="text"
          placeholder="Search for products"
          id="nav-search-input"
          class="form-input !max-w-[600px] !w-full"
          name="search"
          autocomplete="off"
      />
      <script>
        var navSearchInput = document.getElementById('nav-search-input');
        let nameCount = 0;
        window.onload = function() {
          var xhr = new XMLHttpRequest();
          xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
              var products = JSON.parse(xhr.responseText);
              var nameDisplayingSection = document.getElementById('name-displaying-section');
              nameDisplayingSection.innerHTML = ''; // Clearing the previous results
              if (products === null) {
                nameDisplayingSection.innerHTML = '<p>No results found.</p>';
              } else if (products.length === 0) {
                nameDisplayingSection.innerHTML = '';
              } else {
                products.forEach(function(product) {
                  nameCount++;
                  if (nameCount >= 7) return;
                  var productNameElement = document.createElement('li');
                  productNameElement.classList.add('text-neutral-200', 'mt-2');
                  productNameElement.innerHTML = '<a href="<%=request.getContextPath()%>/client/product.jsp?productId='+ product.id +'">' + product.name + '</a>';
                  nameDisplayingSection.appendChild(productNameElement);
                });
              }
            }
          };
          xhr.open('GET', '<%=request.getContextPath()%>/nav-search-product?search=');
          xhr.send();
        }
        navSearchInput.addEventListener('input', function() {
          var searchQuery = navSearchInput.value;
          var xhr = new XMLHttpRequest();
          xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
              var products = JSON.parse(xhr.responseText);
              var displayingSection = document.getElementById('displaying-section');
              displayingSection.innerHTML = ''; // Clearing the previous results
              if (products === null) {
                displayingSection.innerHTML = '<p>No results found.</p>';
              } else if (products.length === 0) {
                displayingSection.innerHTML = '<p>No results found.</p>';
              } else {
                products.forEach(function(product) {
                  var productElement = document.createElement('div');
                  productElement.classList.add('bg-neutral-700', 'rounded-md', 'overflow-hidden', 'p-3', 'space-y-2', 'flex-shrink-0');
                  productElement.style.width = '255px';
                  images = JSON.parse(product.images);
                  productElement.innerHTML = '<img src="<%=request.getContextPath()%>'+ images[0] + '" alt="" class="h-[230px] aspect-square object-cover rounded-md">' +
                          '<div>' +
                          '<a href="<%=request.getContextPath()%>/client/product.jsp?productId='+ product.id +'" class="text-neutral-200 line-clamp-1">' + product.name + '</a>' +
                          '<p class="text-neutral-500 text-base">' + product.category.name + '</p>' +
                          '<p class="text-brand mt-2">NPR. ' + product.price + '</p>' +
                          '</div>';
                  displayingSection.appendChild(productElement);
                });
              }
            }
          };
          xhr.open('GET', '<%=request.getContextPath()%>/nav-search-product?search=' + encodeURIComponent(searchQuery));
          xhr.send();
        });

      </script>

      <%
        }
      %>
      <% if (user != null) { %>
      <div
              class="flex items-center space-x-4 relative cursor-pointer max-w-[175px] w-full"
              id="nav-profile-link-button"
      >
        <img
                src="<%=request.getContextPath()%><%=user.getImage()%>"
                alt="logo"
                class="h-[32px] aspect-square object-cover rounded-md"
                loading="lazy"

        />
        <button class="font-semibold">Hi, <%=user.getFirst_name()%></button>
        <div
                class="absolute top-12 -left-4 max-w-[180px] w-full bg-neutral-600 rounded-md transform scale-0 overflow-hidden transition-all duration-300 ease-in-out"
                id="nav-profile-dropdown"
        >
          <ul class="py-3 w-full">
            <%
              if(user.getRole().equals("admin")){
            %>
            <li class="w-full flex">
              <a
                      href="<%=request.getContextPath()%><%= request.getRequestURI().contains("client") ? "/admin/index.jsp" : "/client/home.jsp" %>"
                      class="!py-3 px-5 hover:bg-neutral-500 transition-all duration-300 ease-in-out w-full"
              >
                <%= request.getRequestURI().contains("client") ? "<i class=\"fa-solid fa-table-columns mr-4 \"></i>" : "<i class=\"fa-solid fa-house mr-4 \"></i>" %>
                <%= request.getRequestURI().contains("client") ? "Dashboard" : "Home" %>
              </a>
            </li>
            <%
              }
            %>
            <li class="w-full flex">
              <a
                      href="<%=request.getContextPath()%>/client/profile.jsp"
                      class="!py-3 px-5 hover:bg-neutral-500 transition-all duration-300 ease-in-out w-full"
              >
                <i class="fa-solid fa-user mr-[22px]"></i>Profile
              </a>
            </li>
            <li class="w-full flex">
              <a
                      href="<%=request.getContextPath()%>/logout-user"
                      class="py-3 px-5 hover:bg-neutral-500 transition-all duration-300 ease-in-out w-full"
              >
                <i class="fa-sharp fa-solid fa-right-from-bracket mr-4"></i>
                Logout
              </a>
            </li>
          </ul>
        </div>
      </div>
      <% } else { %>
      <a
              href="<%=request.getContextPath()%>/index.jsp"
              class="flex items-center space-x-4 relative text-[18px]"
      >
        <i class="fa fa-user-circle-o text-[24px]" aria-hidden="true"></i>
        <span class="font-semibold">Login</span>
      </a>
      <% } %>
    </div>
  </div>
</div>
<%--Nav Search Results--%>
<div
        class="fixed left-0 top-0 h-0 w-full z-[999999999] overflow-hidden transition-all duration-500 ease-in-out"
        id="nav-search-result-div"
>
  <div
          class="bg-bg/30 backdrop-filter backdrop-blur-lg backdrop-saturate-150 h-screen overflow-hidden flex pt-[72px]"
  >
    <div class="w-full bg-neutral-800 min-h-[50vh] h-fit">
      <div class="max-w-[1600px] mx-auto py-[40px]">
        <div class="flex justify-evenly text-white font-semibold text-[22px]">
          <div class="max-w-[600px] flex flex-col justify-between" style="height: 360px;">
            <div>
              <p class="text-neutral-400 w-fit">Top Suggestions</p>
              <ul id="name-displaying-section">

              </ul>
            </div>
          </div>
          <div class="w-fit">
            <div class="w-full flex gap-4 overflow-x-scroll max-w-[1080px] hide-scrollbar" id="displaying-section">
              <%--Data from the api call comes here!--%>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
