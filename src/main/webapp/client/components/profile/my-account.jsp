<div class="space-y-4 w-full">
  <div>
    <h1 class="text-[20px] font-semibold text-neutral-300">
      My Account
    </h1>
  </div>
  <div class="space-y-4 p-6 bg-neutral-800 rounded-lg">
    <!-- Profile Password Edit -->
    <div
            class="disclosure flex flex-row-reverse justify-between items-center p-4"
    >
      <div class="flex flex-col space-y-2">
        <button class="btn-tertiary relative">
          <input
                  type="checkbox"
                  name="disclosure"
                  class="disclosure-button absolute inset-0 opacity-0"
          />
          <span class="disclosure-button-open-text"
          >Edit</span
          >
          <span class="disclosure-button-close-text hidden"
          >Close</span
          >
        </button>
      </div>
      <div class="space-y-2">
        <p class="text-neutral-400">Password</p>
        <p class="text-[18px] disclosure-prev-data">
          ************
        </p>
        <div
                class="disclosure-next-data h-0 overflow-hidden space-y-2"
        >
          <form class="space-y-2 max-w-[350px]" action="<%=request.getContextPath()%>/update-user" method="post" enctype="multipart/form-data">
            <input
                    type="password"
                    name="newPassword"
                    id="newPassword"
                    placeholder="New Password"
                    class="form-input"
            />
            <button
                    type="submit"
                    class="py-2 rounded-md px-8 bg-green-500 border-2 border-green-500"
            >
              <span>Save</span>
            </button>
          </form>
        </div>
      </div>
    </div>
    <hr class="border-neutral-700"/>
    <div
            class="disclosure flex flex-row-reverse justify-between items-center p-4"
    >
      <div class="flex flex-col space-y-2">
        <button class="btn-tertiary relative">
          <input
                  type="checkbox"
                  name="disclosure"
                  class="disclosure-button absolute inset-0 opacity-0"
          />
          <span class="disclosure-button-open-text"
          >Edit</span
          >
          <span class="disclosure-button-close-text hidden"
          >Close</span
          >
        </button>
      </div>
      <div class="space-y-2">
        <p class="text-neutral-400">Address</p>
        <p class="text-[18px] disclosure-prev-data">
            <%=user.getAddress()%>
        </p>
        <div
                class="disclosure-next-data h-0 overflow-hidden space-y-2"
        >
          <form class="space-y-2 max-w-[350px]" action="<%=request.getContextPath()%>/update-user" method="post" enctype="multipart/form-data">
            <input
                    type="text"
                    name="address"
                    id="address"
                    placeholder="New Address"
                    class="form-input"
                    value="<%=user.getAddress()%>"
            />
            <button
                    type="submit"
                    class="py-2 rounded-md px-8 bg-green-500 border-2 border-green-500"
            >
              <span>Save</span>
            </button>
          </form>
        </div>
      </div>
    </div>
    <hr class="border-neutral-700"/>
    <div class="p-4">
      <div class="space-y-2">
        <p class="text-neutral-400">Delete Account</p>
        <p class="text-[18px]">
          You will not be able to recover your account once you have
          deleted your account.
        </p>
      </div>
      <form action="<%=request.getContextPath()%>/delete-account" method="post">
        <input type="hidden" name="id" value="<%=user.getUserId()%>" />
        <button
                class="max-w-[130px] btn-tertiary mt-8 !bg-red-500 !border-red-500"
        >
          DELETE
        </button>
      </form>
    </div>
  </div>
</div>