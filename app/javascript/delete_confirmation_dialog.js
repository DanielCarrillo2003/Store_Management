window.addEventListener("turbo:load", () => {
  document.addEventListener("submit", (event) => {
    if (event.target && event.target.className === "delete-alertbox") {
      event.preventDefault();
      Swal.fire({
        title: "¿Estas seguro de querer realizar esta acción?",
        text: "¡Los cambios no pueden ser revertidos!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Si, eliminar",
        cancelButtonText: "No, cancelar",
      })
        .then((result) => {
          if (result.isConfirmed) {
            document.querySelector(".delete-alertbox").submit();
          }
        })
        .catch(event.preventDefault());
    }
  });
});
