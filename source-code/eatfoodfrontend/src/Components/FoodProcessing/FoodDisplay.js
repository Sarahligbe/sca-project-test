import React, {Component} from 'react';
import '../../index.css';
import Tray from '../Tray/Tray';
import FoodFocus from './FoodFocus.js';
import FoodInventory from './FoodInventory';
import FoodItems from './FooItems';

export default class FoodDisplay extends Component {
    constructor(props){
        super(props);
        this.state = {
            itemFocus : {},
            displayFocusItem: false,
            inventoryActiveTitle: "Today's Top Features",
            inventorySelect : 1,
            trayItems: [],
            displayTray: false,
            totalPrice: 0,
            inventoryActive :  [
                {
                    id: 0,
                    vendorName: "Bola's Cuisines ",
                    item: "Pepper Rice",
                    description: "Rice with plenty heat",
                    price: 1690,
                    vendorLogo: "https://images.unsplash.com/photo-1619454016518-697bc231e7cb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"
                },
                {
                    id: 1,
                    vendorName: "Bola's Cuisines ",
                    item:'Pepper Rice',
                    description: "Rice with plenty heat",
                    price: 1690,
                    vendorLogo: "https://images.unsplash.com/photo-1619454016518-697bc231e7cb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"
                },
                {
                    id: 2,
                    vendorName: "Smokies's ",
                    item: "Barbecue Fish",
                    description: "Barbecue fish with fries",
                    price: 2299,
                    vendorLogo: "https://images.unsplash.com/photo-1575395311793-ad870d50fbd1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=872&q=80"
                },
                {
                    id: 3,
                    vendorName: "Osas's ",
                    item: "Oriental Noodles",
                    description: "Oriental style noodles",
                    price: 1100,
                    vendorLogo: "https://images.unsplash.com/photo-1628557010295-dd9198c31b84?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1032&q=80"
                },
                {
                    id: 4,
                    vendorName: "Charley Chow's ",
                    item: "Chicken Wings",
                    description: "Enjoy wings grilled with passion for ",
                    price: 800,
                    vendorLogo: ""
                },
            ],
            allOptions: [
                {
                    name: "Mains",
                    topRatedFoods : [
                        {
                            id: 0,
                            vendorName: "Bola's Cuisines ",
                            item: "Pepper Rice",
                            description: "Rice with plenty heat",
                            price: 1690,
                            foodImg: 'https://images.unsplash.com/photo-1569058242252-623df46b5025?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                            vendorLogo: "https://images.unsplash.com/photo-1619454016518-697bc231e7cb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"
                        },
                        {
                            id: 1,
                            vendorName: "Bola's Cuisines ",
                            item:'Pepper Rice',
                            description: "Rice with plenty heat",
                            price: 1690,
                            foodImg: 'https://images.unsplash.com/photo-1569058242252-623df46b5025?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                            vendorLogo: "https://images.unsplash.com/photo-1619454016518-697bc231e7cb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"
                        },
                        {
                            id: 2,
                            vendorName: "Smokies's ",
                            item: "Barbecue Fish",
                            description: "Barbecue fish with fries",
                            price: 2299,
                            foodImg: 'https://media.istockphoto.com/id/914755250/photo/fish-dish-salmon-steak-and-vegetables.webp?s=612x612&w=is&k=20&c=M3pk5RcCEQTSaVLTKrOa07B-jKcX42nCitKXXnTUdiY=',
                            vendorLogo: "https://images.unsplash.com/photo-1575395311793-ad870d50fbd1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=872&q=80"
                        },
                        {
                            id: 3,
                            vendorName: "Osas's ",
                            item: "Oriental Noodles",
                            description: "Oriental style noodles",
                            price: 1100,
                            foodImg: 'https://images.unsplash.com/photo-1585032226651-759b368d7246?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=692&q=80',
                            vendorLogo: "https://images.unsplash.com/photo-1628557010295-dd9198c31b84?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1032&q=80"
                        },
                        {
                            id: 4,
                            vendorName: "Charley Chow's ",
                            item: "Chicken Wings",
                            description: "Enjoy wings grilled with passion for ",
                            price: 800,
                            foodImg: 'https://plus.unsplash.com/premium_photo-1669742928007-71b99d6ab1dd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                            vendorLogo: "https://images.unsplash.com/photo-1668837587937-7909f7ccb7d8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80"
                        },
                        {
                            id: 0,
                            vendorName: "Bola's Cuisines ",
                            item: "Pepper Rice",
                            description: "Rice with plenty heat",
                            price: 1690,
                            foodImg: 'https://images.unsplash.com/photo-1569058242252-623df46b5025?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                            vendorLogo: "https://images.unsplash.com/photo-1619454016518-697bc231e7cb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"
                        },
                        {
                            id: 1,
                            vendorName: "Bola's Cuisines ",
                            item:'Pepper Rice',
                            description: "Rice with plenty heat",
                            price: 1690,
                            foodImg: 'https://images.unsplash.com/photo-1569058242252-623df46b5025?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                            vendorLogo: "https://images.unsplash.com/photo-1619454016518-697bc231e7cb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"
                        },
                        {
                            id: 2,
                            vendorName: "Smokies's ",
                            item: "Barbecue Fish",
                            description: "Barbecue fish with fries",
                            price: 2299,
                            foodImg: 'https://media.istockphoto.com/id/914755250/photo/fish-dish-salmon-steak-and-vegetables.webp?s=612x612&w=is&k=20&c=M3pk5RcCEQTSaVLTKrOa07B-jKcX42nCitKXXnTUdiY=',
                            vendorLogo: "https://images.unsplash.com/photo-1575395311793-ad870d50fbd1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=872&q=80"
                        },
                        {
                            id: 3,
                            vendorName: "Osas's ",
                            item: "Oriental Noodles",
                            description: "Oriental style noodles",
                            price: 1100,
                            foodImg: 'https://images.unsplash.com/photo-1585032226651-759b368d7246?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=692&q=80',
                            vendorLogo: "https://images.unsplash.com/photo-1628557010295-dd9198c31b84?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1032&q=80"
                        },
                        {
                            id: 4,
                            vendorName: "Charley Chow's ",
                            item: "Chicken Wings",
                            description: "Enjoy wings grilled with passion for ",
                            price: 800,
                            foodImg: 'https://plus.unsplash.com/premium_photo-1669742928007-71b99d6ab1dd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                            vendorLogo: "https://images.unsplash.com/photo-1668837587937-7909f7ccb7d8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80"
                        },
                    ],
                },
                {
                    name: "Drinks",
                    topRatedFoods : [
                        {
                            id: 0,
                            vendorName: "Regal's Cuisines ",
                            item: "Friuty flavoured beers",
                            description: "Rice with plenty heat",
                            price: 1690,
                            foodImg: 'https://media.istockphoto.com/id/517500200/photo/sour-grapefruit-craft-beer.jpg?s=612x612&w=is&k=20&c=c5lrw8cHqJp5FKTqiNydWEPE987xzyIyq_usuWQ4pNY=',
                            vendorLogo: "https://images.unsplash.com/photo-1663998241979-e186e4e30abb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=436&q=80"
                        },
                        {
                            id: 1,
                            vendorName: "Bola's Cuisines ",
                            item:'Cola Rolas',
                            description: "Rice with plenty heat",
                            price: 1690,
                            foodImg: 'https://images.unsplash.com/photo-1613510214658-f1e56b099811?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1032&q=80',
                            vendorLogo: "https://images.unsplash.com/photo-1663322398558-eddaac0ad931?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80"
                        },
                        {
                            id: 2,
                            vendorName: "Saysay",
                            item: "Calm Drinks",
                            description: "Barbecue fish with fries",
                            price: 2299,
                            foodImg: 'https://images.unsplash.com/photo-1499638673689-79a0b5115d87?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
                            vendorLogo: "https://images.unsplash.com/photo-1640516050694-590a128e69f6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"
                        },
                        {
                            id: 3,
                            vendorName: "Osas's Pinas",
                            item: "Pinas",
                            description: "Oriental style noodles",
                            price: 1100,
                            foodImg: 'https://images.unsplash.com/photo-1607446045710-d5a8fd9bc1db?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                            vendorLogo: "https://images.unsplash.com/photo-1518597222911-9c4a76e71615?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1032&q=80"
                        },
                        {
                            id: 4,
                            vendorName: "Fresko",
                            item: "Fresh Smoothie",
                            description: "Enjoy wings grilled with passion for ",
                            price: 800,
                            foodImg: 'https://images.unsplash.com/photo-1505252585461-04db1eb84625?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=408&q=80',
                            vendorLogo: "https://images.unsplash.com/photo-1559627366-33f1b511a5da?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"
                        },
                        {
                            id: 0,
                            vendorName: "Regal's Cuisines ",
                            item: "Friuty flavoured beers",
                            description: "Rice with plenty heat",
                            price: 1690,
                            foodImg: 'https://media.istockphoto.com/id/517500200/photo/sour-grapefruit-craft-beer.jpg?s=612x612&w=is&k=20&c=c5lrw8cHqJp5FKTqiNydWEPE987xzyIyq_usuWQ4pNY=',
                            vendorLogo: "https://images.unsplash.com/photo-1663998241979-e186e4e30abb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=436&q=80"
                        },
                        {
                            id: 1,
                            vendorName: "Bola's Cuisines ",
                            item:'Cola Rolas',
                            description: "Rice with plenty heat",
                            price: 1690,
                            foodImg: 'https://images.unsplash.com/photo-1613510214658-f1e56b099811?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1032&q=80',
                            vendorLogo: "https://images.unsplash.com/photo-1663322398558-eddaac0ad931?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80"
                        },
                        {
                            id: 2,
                            vendorName: "Saysay",
                            item: "Calm Drinks",
                            description: "Barbecue fish with fries",
                            price: 2299,
                            foodImg: 'https://images.unsplash.com/photo-1499638673689-79a0b5115d87?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
                            vendorLogo: "https://images.unsplash.com/photo-1640516050694-590a128e69f6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"
                        },
                        {
                            id: 3,
                            vendorName: "Osas's Pinas",
                            item: "Pinas",
                            description: "Oriental style noodles",
                            price: 1100,
                            foodImg: 'https://images.unsplash.com/photo-1607446045710-d5a8fd9bc1db?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                            vendorLogo: "https://images.unsplash.com/photo-1518597222911-9c4a76e71615?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1032&q=80"
                        },
                        {
                            id: 4,
                            vendorName: "Fresko",
                            item: "Fresh Smoothie",
                            description: "Enjoy wings grilled with passion for ",
                            price: 800,
                            foodImg: 'https://images.unsplash.com/photo-1505252585461-04db1eb84625?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=408&q=80',
                            vendorLogo: "https://images.unsplash.com/photo-1559627366-33f1b511a5da?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"
                        },
                    ],
                }
            ],
            topRatedFoods : [
                {
                    id: 0,
                    vendorName: "Bola's Cuisines ",
                    item: "Pepper Rice",
                    description: "Rice with plenty heat",
                    price: 1690,
                    vendorLogo: ""
                },
                {
                    id: 1,
                    vendorName: "Bola's Cuisines ",
                    item:'Pepper Rice',
                    description: "Rice with plenty heat",
                    price: 1690,
                    vendorLogo: ""
                },
                {
                    id: 2,
                    vendorName: "Smokies's ",
                    item: "Barbecue Fish",
                    description: "Barbecue fish with fries",
                    price: 2299,
                    vendorLogo: ""
                }, 
                {
                    id: 3,
                    vendorName: "Osas's ",
                    item: "Oriental Noodles",
                    description: "Oriental style noodles",
                    price: 1100,
                    vendorLogo: ""
                },
                {
                    id: 4,
                    vendorName: "Charley Chow's ",
                    item: "Chicken Wings",
                    description: "Enjoy wings grilled with passion for ",
                    price: 800,
                    vendorLogo: ""
                },
            ],
            // activeDisplay: props.activeDisplay
        }
    }

    focusItem(id){
        this.setState({
            itemFocus: this.state.allOptions[this.state.inventorySelect].topRatedFoods[id],
            displayFocusItem: true,
            displayTray: false
        })
        console.log(this.state.topRatedFoods[id])
        console.log(this.state.inventoryActive)

    }
    
    renderFoodItems() {
        return(
            <div>
                <FoodItems
                    expandFoodItem = {(id) => this.inventoryExpand(id)}
                />
            </div>
        )
    }

    addToTray(item){
        console.log(this.state.trayItems)
        this.calcTotalPrice()
        // this.setState({
        //     trayItems: this.state.trayItems.push(item)
        // })
        
        this.setState(previousState => ({
            trayItems: [...previousState.trayItems, item]
        }));
        console.log(this.state.trayItems)
        
        
    }

    calcTotalPrice(){
        // Create total price variable
        let currentTotalPrice = 0
        // Loop through dictionary elements in the list
        for( let i=0; i < this.state.trayItems.length; i++){
            let price = this.state.trayItems[i]['price']
            currentTotalPrice +=  price
            console.log(currentTotalPrice)

            this.setState({
                totalPrice: currentTotalPrice
            })
            console.log(this.state.totalPrice)
        }
        console.log(currentTotalPrice)
        

        
        // Get the Price for each element
        // Add total price variable
    }

    renderFoodInventory(){
        
        return(
            <div>
                <FoodInventory
                    
                    foodItems = {this.state.inventoryActive}
                    focusItem = {(id) => this.focusItem(id)}
                />
            </div>
        )
    }

    inventoryExpand(id){
        this.setState({
            inventorySelect: id,
            inventoryActive: this.state.allOptions[id].topRatedFoods,
            inventoryActiveTitle : this.state.allOptions[id].name
        })
        // console.log(this.state.inventorySelect)
        // console.log(this.state.inventoryActive)
        // console.log(typeof(this.state.inventoryActive))
        // this.renderFoodInventory()
        return this.state.inventoryActive;
    }


    render () {
        return(
            <div className=' mx-2'>
                <div className=''>
                    <div className='lg:w-4/5 m-auto'>
                        <FoodItems
                            expandFoodItem = {(id) => this.inventoryExpand(id)}
                        />
                    </div>

                </div>
                <div className='text-3xl font-extrabold text-slate-600 px-5 pb-4 ' >{this.state.inventoryActiveTitle}</div>
                <div className='md:flex w-full relative max-sm:overflow-y-scroll'>

                    <div className={this.state.displayFocusItem === false? 'basis-2/5' : ' md:block basis-2/5'}>
                        
                        {this.renderFoodInventory()}
                    </div>
                    <div className='w-full basis-3/5 h-full'>
                    <div className='absolute w-full left-0 right-0 top-0 md:relative' >
                        <div className={this.state.displayFocusItem === false? ' px-3 hidden md:my-2 md:block' :'px-3 relative left-0 right-0 md:relative bg-white'}>
                            <div className= 'flex justify-between pb-3'>
                                <div className='mt-3'>
                                    <svg  onClick={() => this.setState({displayTray: false, displayFocusItem: false})} xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class={this.state.displayTray === false? 'md:hidden' : 'block h-6 w-6'} style={{height: '2rem'}}>
                                    <path className='text-lg font-bold text-slate-700' fill-rule="evenodd" d="M20.25 12a.75.75 0 01-.75.75H6.31l5.47 5.47a.75.75 0 11-1.06 1.06l-6.75-6.75a.75.75 0 010-1.06l6.75-6.75a.75.75 0 111.06 1.06l-5.47 5.47H19.5a.75.75 0 01.75.75z" clip-rule="evenodd" />
                                    </svg>
                                </div>
                                <div className='mt-3 text-slate-800'>
                                    <button onClick={() => this.setState({displayTray: !this.state.displayTray})} className={this.state.displayTray === false ? 'block px-4 py-1 text-sm font-semibold rounded' : 'hidden'}>Open tray</button>
                                    <button onClick={() => this.setState({displayTray: !this.state.displayTray})} className={this.state.displayTray === true ? 'block font-semibold px-4 py-2 text-sm' : 'hidden'}>Close tray</button>
                                </div>
                            </div>
                            
                            <div className='relative items-center'>
                                <div>
                                    <div className={this.state.displayTray === true? 'hidden' : 'block slide-left-stay'}>
                                    <FoodFocus
                                    // itemInFocus = {this.state.showFocusItem} 
                                    vendorName = {this.state.itemFocus.vendorName}
                                    item = {this.state.itemFocus.item}
                                    description = {this.state.itemFocus.description}
                                    vendorLogo = {this.state.itemFocus.vendorLogo}
                                    foodImg = {this.state.itemFocus.foodImg}
                                    price = {this.state.itemFocus.price}
                                    addToTray = {() => this.addToTray(this.state.itemFocus)}
                                    />
                                    </div>
                                
                                <div className={this.state.displayTray === false? 'hidden' : 'block slide-in-stay'}>
                                    <Tray
                                        trayItems={this.state.trayItems}
                                        totalPrice ={this.state.totalPrice}
                                    />
                                </div>
                            </div>
                            </div>
                        </div>
                    </div>
                    </div>
                    
                    
                </div>
                
            </div>
        )
    }
}
