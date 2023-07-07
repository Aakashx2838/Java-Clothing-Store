<div class="space-y-4 w-full text-white">
  <div>
    <h1 class="text-[20px] font-semibold text-neutral-300">
      My Profile
    </h1>
  </div>
  <div class="space-y-4 p-6 bg-neutral-800 rounded-lg">
    <!-- Profile Picture Edit -->
    <div class="flex items-center justify-between p-4">
      <div
              class="flex space-x-4 items-center text-base text-neutral-400"
      >
        <img
                src="<%=request.getContextPath() + user.getImage()%>"
                alt="user profile pic"
                class="h-[85px] aspect-square rounded-full object-cover"
                loading="lazy"
        />
        <span>Profile Picture</span>
      </div>
        <form action="<%=request.getContextPath()%>/update-user" method="post" enctype="multipart/form-data" class="space-y-2">
          <div
                  class="relative max-w-[130px] btn-tertiary overflow-hidden"
          >
              <input type="file" class="absolute inset-0 opacity-0" id="profile_picture" name="profile_picture" accept="image/*"/>
              <span>Upload</span>
          </div>
          <button
                  id="image-save-button"
                  type="submit"
                  class="py-2 rounded-md max-w-[130px] w-full px-8 bg-green-500 border-2 border-green-500 hidden"
                  disabled
          >
            <script>
                document.getElementById("profile_picture").onchange = function () {
                    if (this.value) {
                        let btn = document.querySelector("#image-save-button");
                        btn.classList.remove("hidden");
                        btn.removeAttribute("disabled");
                    } else {
                        let btn = document.querySelector("#image-save-button");
                        btn.classList.add("hidden");
                        btn.setAttribute("disabled", "true");
                    }
                };
            </script>
            <span>Save</span>
          </button>
        </form>
    </div>
    <hr class="border-neutral-700"/>
    <!-- Name edit -->
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
          <span class="disclosure-button-open-text">Edit</span>
          <span class="disclosure-button-close-text hidden"
          >Close</span
          >
        </button>
      </div>
      <div class="space-y-2">
        <p class="text-neutral-400">Full Name</p>
        <p class="disclosure-prev-data text-[18px] capitalize">
          <%=user.getFirst_name()%> <%=user.getLast_name()%>
        </p>
        <div
                class="disclosure-next-data h-0 overflow-hidden"
        >
          <form class="space-y-2 max-w-[350px]" action="<%=request.getContextPath()%>/update-user" method="post" enctype="multipart/form-data">
            <input
                    type="text"
                    name="first_name"
                    id="first_name"
                    placeholder="<%=user.getFirst_name()%>"
                    value="<%=user.getFirst_name()%>"
                    class="form-input"
            />
            <input
                    type="text"
                    name="last_name"
                    id="last_name"
                    placeholder="<%=user.getLast_name()%>"
                    value="<%=user.getLast_name()%>"
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
    <!-- Email edit -->
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
          <span class="disclosure-button-open-text">Edit</span>
          <span class="disclosure-button-close-text hidden"
          >Close</span
          >
        </button>
      </div>
      <div class="space-y-2">
        <p class="text-neutral-400">Email</p>
        <p class="text-[18px] disclosure-prev-data">
          <%=user.getEmail()%>
        </p>
        <div
                class="disclosure-next-data h-0 overflow-hidden space-y-4"
        >
          <form class="space-y-2 max-w-[350px]" action="<%=request.getContextPath()%>/update-user" method="post" enctype="multipart/form-data">
            <input
                    type="email"
                    name="email"
                    id="email"
                    placeholder="<%=user.getEmail()%>"
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
    <!-- Contact Edit -->
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
          <span class="disclosure-button-open-text">Edit</span>
          <span class="disclosure-button-close-text hidden"
          >Close</span
          >
        </button>
      </div>
      <div class="space-y-2">
        <p class="text-neutral-400">Phone</p>
        <p class="text-[18px] disclosure-prev-data">
          <%=user.getPhone()%>
        </p>
        <div
                class="disclosure-next-data h-0 overflow-hidden space-y-4"
        >
          <form class="space-y-2 max-w-[350px]" action="<%=request.getContextPath()%>/update-user" method="post" enctype="multipart/form-data">
            <input
                    type="number"
                    name="phoneNumber"
                    id="phoneNumber"
                    placeholder="<%=user.getPhone()%>"
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
    <!-- Date of Birth Edit -->
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
          <span class="disclosure-button-open-text">Edit</span>
          <span class="disclosure-button-close-text hidden"
          >Close</span
          >
        </button>
      </div>
      <div class="space-y-2">
        <p class="text-neutral-400">Date Of Birth</p>
        <p class="text-[18px] disclosure-prev-data"><%=user.getDateOfBirth()%>
        </p>
        <div
          class="disclosure-next-data h-0 overflow-hidden space-y-4"
        >
          <form class="space-y-2 max-w-[350px]" action="<%=request.getContextPath()%>/update-user" method="post" enctype="multipart/form-data">
            <input
              type="date"
              name="dateOfBirth"
              id="dateOfBirth"
              placeholder="<%=user.getDateOfBirth()%>"
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
    <!-- Gender Edit -->
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
          <span class="disclosure-button-open-text">Edit</span>
          <span class="disclosure-button-close-text hidden"
          >Close</span
          >
        </button>
      </div>
      <div class="space-y-2">
        <p class="text-neutral-400">Sex</p>
        <p class="text-[18px] disclosure-prev-data capitalize"><%=user.getSex()%>
        </p>
        <div
          class="disclosure-next-data h-0 overflow-hidden flex space-x-4"
        >
          <form method="post" action="<%=request.getContextPath()%>/update-user" enctype="multipart/form-data">
            <label for="male">
              <input
                type="radio"
                name="sex"
                id="male"
                value="male"
                class="h-4 aspect-square"
                <%
                  if (user.getSex().equals("male")) {
                    out.println("checked");
                  } else {
                    out.println("");
                  }
                %>
              />
              Male
            </label>
            <label for="female">
              <input
                type="radio"
                name="sex"
                id="female"
                value="female"
                class="h-4 aspect-square"
                <%
                  if (user.getSex().equals("female")) {
                    out.println("checked");
                  } else {
                    out.println("");
                  }
                %>
              />
              Female
            </label>
            <label for="other">
              <input
                type="radio"
                name="sex"
                id="other"
                value="other"
                class="h-4 aspect-square"
                <%
                  if (user.getSex().equals("other")) {
                    out.println("checked");
                  } else {
                    out.println("");
                  }
                %>
              />
              Other
            </label>
            <br />
            <br />
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
  </div>
</div>