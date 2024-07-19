export default function sendRequest (url, method, data, callback) {
  $.ajax({
    url: url,
    type: method,
    dataType: "script",
    data: data,
    success: callback(data),
    error: function (error) {
      console.log(error);
    },
  });
};
