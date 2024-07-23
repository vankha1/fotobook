import setDebounce from '../common/debounce'
const searchInput = $("#search_input");

// Debounce the search input
searchInput.on(
  "input",
  setDebounce(() => {
    const searchValue = searchInput.val();
    console.log(searchValue);
    if (!searchValue) {
      $("#search_result").empty();
      $("#search_result").hide();
      return;
    }

    $.ajax({
      url: "/search",
      method: "GET",
      data: { key: searchValue },
      dataType: "json", 
      success: (response) => {
        $("#search_result").empty();
        $("#search_result").show();
        if (response.length === 0) {
          $("#search_result").append(`
                    <h6 class="text-center text-dark mt-3">No results found</h6>
                `);
        } else {
          response.forEach((item) => {
            console.log(item.id);
            const searchItem = $(`
                        <div class="card photo" id="search_item" data-id="${
                          item.id
                        }" data-bs-target="#${item.id}">
                            <img src="${
                              item.image_url && item.image_url.url
                                ? item.image_url.url
                                : "/assets/default_photo.jpg"
                            }" class="search_photo" alt="...">
                            <h6 class="search_title">${item.title}</h6>
                        </div>
                    `);
            $("#search_result").append(searchItem);
          });
        }
      },
      error: (jqXHR, textStatus, errorThrown) => {
        console.error(
          "Error fetching search results:",
          textStatus,
          errorThrown
        );
      },
    });
  }, 1000)
);

// Blur out the input and search result when clicked outside
$(document).on("click", (e) => {
  if (
    !$(e.target).closest("#search_result").length &&
    !$(e.target).closest("#search_input").length
  ) {
    $("#search_result").hide();
  }
});

// And when click input again, make request and show result again
searchInput.on("click", () => {
  const searchValue = searchInput.val();
  if (searchValue) {
    $("#search_result").show();
  }
});
