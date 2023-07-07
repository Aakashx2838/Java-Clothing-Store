<div class="h-full w-full flex justify-end">
  <div
    class="max-w-[460px] w-full h-fit rounded-xl p-6 bg-neutral-700"
  >
    <div class="w-full space-y-4">
      <h1 class="text-[28px] font-semibold text-white">
        <%= product.getName() %>
      </h1>
      <div class="flex justify-between items-center">
        <p class="text-brand text-[20px] font-medium">
          NPR. <%= product.getPrice() %>
        </p>
        <p>
          <i class="fa-solid fa-star text-brand"></i>
          <span class="text-base text-neutral-400"> <%=product.getRating()%> (<%=product.getReviews()%>) </span>
        </p>
      </div>
      <div class="py-4">
        <form class="space-y-8" action="<%=request.getContextPath()%>/add-to-cart" method="post">
          <div class="space-y-2 font-medium text-white">
            <p class="text-base font-semibold text-neutral-200">
              Color
            </p>
            <div class="flex flex-wrap gap-4">
              <%
                for (String color : product.getColorArray()) {
              %>
                <div
                  class="relative w-[100px] aspect-square rounded-xl bg-neutral-600"
              >
                <input
                  type="radio"
                  name="color"
                  value="<%= color %>"
                  class="color-selector absolute inset-0 opacity-0"
                  required
                />
                <div
                  class="color-selector-div aboslute inset-0 z-50 h-full flex items-center justify-center flex-col space-y-1 rounded-xl"
                >
                  <div
                    class="h-[40px] aspect-square rounded-full border-2 border-neutral-900"
                    style="background-color: <%= color %>"
                  ></div>
                  <p><%= color %></p>
                </div>
              </div>
              <%
                }
              %>
            </div>
          </div>
          <div class="space-y-2 font-medium text-white">
            <p class="text-base font-semibold text-neutral-200">
              Size
            </p>
            <div class="flex flex-wrap gap-4">
              <%
                for (String size : product.getSizeArray()) {
              %>
                <div
                class="relative aspect-square w-[45px] rounded-xl bg-neutral-600"
              >
                <input
                  type="radio"
                  name="size"
                  value="<%= size %>"
                  class="color-selector absolute inset-0 opacity-0"
                  required
                />
                <div
                  class="color-selector-div aboslute inset-0 z-50 h-full flex items-center justify-center flex-col space-y-1 rounded-xl"
                >
                  <p><%=size%></p>
                </div>
              </div>
              <%
                  }
              %>
            </div>
          </div>
          <% if(product.getQuantity()==0){ %>
              <div
                class="text-red-500 text-center py-3 bg-red-500/10 rounded-2xl px-5"
              >
                Out of stock, add to wishlist to get notified when it's back in stock
              </div>
          <% } else { %>
              <div
                class="text-green-500 text-center py-3 bg-green-500/10 rounded-2xl px-5"
              >
                Available in stock. <%=product.getQuantity()%> left in stock
              </div>
            <% } %>
          <input type="hidden" id="productId" name="productId" value="<%=product.getId()%>">
          <div class="flex space-x-4">
            <button
              class="btn-primary !border-brand !rounded-md !max-w-full !w-full"
              type="submit"
              <%=product.getQuantity()==0?"disabled":""%>
            >
              Add to Bag
              <i class="fa-solid fa-cart-shopping ml-2"></i>
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>