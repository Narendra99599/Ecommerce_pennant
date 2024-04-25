
let itemContainer = document.querySelector(".items");

function addProducts(){
    let data = JSON.parse(localStorage.getItem('cartData'));
    data.map(productsData => {
        let item = document.createElement('div');
        let title = document.createElement('p');
        let image = document.createElement('img');
        let price = document.createElement('p');
        let button = document.createElement('button');
        let plusbutton = document.createElement('button');
        let minusbutton = document.createElement('button');
        let p = document.createElement('p');

        p.innerText = productsData.count;
        plusbutton.innerText = "+";
        minusbutton.innerText = "-";

        button.id = productsData.id;
        button.innerText = "remove";
        button.classList.add('btn');

        item.classList.add('item');
        title.innerText = productsData.title;
        image.setAttribute('src',productsData.image);
        price.innerText = productsData.price;
        item.append(title);
        item.append(image);
        item.append(price);
        item.append(button);
        item.append(plusbutton);
        item.append(p);
        item.append(minusbutton);
        itemContainer.append(item);

        document.querySelector('.number').innerText = data.length;
        button.addEventListener('click' , () => {
            let data = JSON.parse(localStorage.getItem('cartData'));
            let filterData = data.filter((ele) => ele.id != productsData.id);
            localStorage.setItem('cartData', JSON.stringify(filterData));
            location.reload();
        })

             plusbutton.addEventListener('click' , () => {
            let data = JSON.parse(localStorage.getItem('cartData'));
            data.forEach(element => {
                if(element.id === productsData.id)
                    element.count++;
            });
            localStorage.setItem('cartData', JSON.stringify(data));
            location.reload();
        })

        minusbutton.addEventListener('click' , () => {
            let data = JSON.parse(localStorage.getItem('cartData'));
            data.forEach(element => {
                if(element.id === productsData.id)
                    element.count--;
            });
            localStorage.setItem('cartData', JSON.stringify(data));
            location.reload();
        })

    })
}

function generate(){
	let data = JSON.parse(localStorage.getItem('cartData'));
     var table = document.getElementById("tableData");
  	table.innerHTML = "";
    var header = table.createTHead();
    var row = header.insertRow();

    // Table headers
    var headers = ["id", "name", "price", "quantity", "totalprice"];
    headers.forEach(function(headerText) {
        var th = document.createElement("th");
        var text = document.createTextNode(headerText);
        th.appendChild(text);
        row.appendChild(th);
    });
	var tbody = document.createElement("tbody");
	 data.forEach(function(item) {
        var tr = tbody.insertRow();
        for (var key in item) {
			if(key === "image" || key === "description" || key === "category" || key === "rating")
				continue;
            var cell = tr.insertCell();
            var text = document.createTextNode(item[key]);
            cell.appendChild(text);
        }
        var totalprice = item.count * item.price;
        var totalCell = tr.insertCell();
        var totalText = document.createTextNode(totalprice);
        totalCell.appendChild(totalText);
    });

    table.appendChild(tbody);
	var modal = document.getElementById("myModal");
	 modal.style.display = "block";
}

function closeModal() {
    var modal = document.getElementById("myModal");
    modal.style.display = "none";
}

// Close the modal if the user clicks outside of it
window.onclick = function(event) {
    var modal = document.getElementById("myModal");
    if (event.target == modal) {
        modal.style.display = "none";
    }
}

document.querySelector('.checkoutbtn').addEventListener('click',generate);

addProducts();
