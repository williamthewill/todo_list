const ManipuleTodoList = {
    mounted() {
        let searchtimer;
        this.el.addEventListener("input", e => {
            clearTimeout(searchtimer);

            if (this.el.value != "") {
                searchtimer = setTimeout(() => {
                    this.pushEvent("update_description", { id: e.srcElement.getAttribute("todo-id"), updated_description: e.srcElement.value });
                }, 500);
            }
        });

        this.el.addEventListener("keypress", (e) => {
            if (e.key === "Enter") {
                e.preventDefault();
                const nodes = Array.from(this.el.parentNode.parentNode.children)
                const index_previous_sibling = nodes.indexOf(this.el.parentNode)
                this.pushEvent("new_todo", { index_previous_sibling: index_previous_sibling });
            }
        });

        this.el.addEventListener("keydown", (e) => {
            if (e.key === "Backspace" && this.el.value == "") {
                this.pushEvent("delete_todo", { id: e.srcElement.getAttribute("todo-id") });
            }
        });
    }
}

export default ManipuleTodoList