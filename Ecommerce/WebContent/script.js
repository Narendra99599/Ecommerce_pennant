let data = [];

let itemContainer = document.querySelector(".items");

function addToCart(item){  
   let cartData = JSON.parse(localStorage.getItem('cartData')) || [];
    if(cartData.length === 0){
        item = {...item, count : 1}
        cartData.push(item);
		console.log("in if",cartData)
    }else{
		let present = false;
       /* cartData.forEach(obj => {
            if(obj.id === item.id){
                obj.count++;
               	return;
            }else{
                item = {...item, count : 1}
                cartData.push(item);
				return;
            }
        })*/
		for(let i=0; i<cartData.length; i++){
			if(cartData[i].id === item.id){
				cartData[i].count++;
				present = true;
				console.log("in loop",cartData);
				break;
			}
		}
		if(!present){
			item = {...item, count : 1};
			cartData.push(item);
			console.log("in if if ",cartData);
		}
    }
    localStorage.setItem('cartData', JSON.stringify(cartData));
    document.querySelector('.number').innerText = cartData.length;
}

function addProducts(){
    data.map(productsData => {
        let item = document.createElement('div');
        let title = document.createElement('p');
        let image = document.createElement('img');
        let price = document.createElement('p');
        let button = document.createElement('button');
        button.id = productsData.id;
        button.innerText = "add";
        button.classList.add('btn');
        item.classList.add('item');
        title.innerText = productsData.title;
        image.setAttribute('src',productsData.image);
        price.innerText = productsData.price;
        item.append(title);
        item.append(image);
        item.append(price);
        item.append(button);
        itemContainer.append(item);
        button.addEventListener('click',() => addToCart(productsData));
        let cartData = JSON.parse(localStorage.getItem('cartData')) || [];
        console.log(cartData.length);
        document.querySelector('.number').innerText = cartData.length;
    })
}

async function getData(){
    try{
        let response = await fetch("https://fakestoreapi.com/products");
        let productsData = await response.json();
        data = productsData;
        console.log(data);
        addProducts();
    }catch(error){
        console.log(error.message);
    }
}

getData();