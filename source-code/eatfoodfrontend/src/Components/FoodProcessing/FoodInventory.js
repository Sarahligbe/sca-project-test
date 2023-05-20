import React, {Component} from 'react';
import '../../index.css';


export default class FoodInventory extends Component {
    constructor(props){
        super(props);
        this.state = {
            foodItems: [
                {
                id: 0,
                vendorName: "Regal's Cuisines ",
                item: "Friuty flavoured beers",
                description: "Rice with plenty heat",
                img: ""
                },
                {
                    id: 1,
                    vendorName: "Bola's Cuisines ",
                    item:'Cola Rolas',
                    description: "Rice with plenty heat",
                    img: ""
                },
                {
                    id: 2,
                    vendorName: "Saysay",
                    item: "Calm Drinks",
                    description: "Barbecue fish with fries",
                    img: ""
                },
                {
                    id: 3,
                    vendorName: "Osas's Pinas",
                    item: "Pinas",
                    description: "Oriental style noodles",
                    img: ""
                },
                {
                    id: 4,
                    vendorName: "Fresko",
                    item: "Fresh Smoothie",
                    description: "Enjoy wings grilled with passion for ",
                    img: ""
                },
            ]
        }
        
    }

    getItems(){
        let foodItems = this.props.foodItems()
        this.setState({
            foodItems: foodItems
        })
        console.log("getItem has run")
    }

    // foodOp return the value of the selected food inventory from FoodDisplay
    // parent component through the foodItems prop
    foodOp = this.props.foodItems
    
    
    
    render () {
        
        return(
            <div className=' scroll-m-4 pb-3 rounded-2xl divide-y divide-slate-100'>
                <div className='flex justify-start pb-4 text-sm font-medium'>
                <div className='pl-4 '><button className='rounded-lg space-x-3 text-slate-400 bg-slate-50 focus:bg-sky-500 focus:text-white px-3 py-2'>All</button></div>
                    <div className='pl-2 '><button className='rounded-lg space-x-3 text-slate-400 bg-slate-50 focus:bg-sky-500 focus:text-white px-3 py-2'>Top Rated</button></div>
                    <div className='px-2'><button className='rounded-lg space-x-4 text-slate-400 bg-slate-50 focus:text-white px-3 py-2 focus:bg-sky-500 '>Economy</button></div>
                </div>
                <div className='overflow-y-scroll h-132 md:h-96 overflow-x-hidden border-2'>
                {this.props.foodItems.map(food => {
                    return(

                        <div className=' group flex items-start text-gray-400 hover:bg-gray-100 border-gray-100 hover:text-gray-500 m-aut0'>
                            <button onClick={() => this.props.focusItem(food.id)} className='w-full '>
                                <div className='flex w-full justify-between'>
                                    <div className='flex items-center'>
                                        <div className='w-14 h-14 rounded-full border-y-red-600 border-4 ml-1 my-2'>
                                            <img src={food.vendorLogo} alt='item' className='rounded-full min-w-full min-h-full max-h-full ' 
                                            style={{objectFit: 'cover'}}/>
                                            </div>
                                            <div className=' pl-4 truncate'>
                                            <dl>
                                                <dt><div className='text-sm text-left pt-1 text-slate-900'><span className='font-medium text-slate-400 text-xs'><dd>{food.vendorName}</dd></span><span className='font-bold'><dd>{food.item}</dd></span></div></dt>
                                                <dt><div className='text-left text-xs'>{food.description}</div></dt>
                                            </dl>
                                        </div>
                                    </div>
                                    <div>
                                        
                                    </div>
                                    
                                    
                                </div>
                            </button>
                            <div className='h-20 w-2/5'>
                                <img src={food.foodImg} alt='' className=' min-w-full min-h-full max-h-full rounded-sm'
                                    style={{objectFit: 'cover', clipPath: 'polygon(0% 100%, 50% 0%, 100% 0, 100% 100%, 0% 100%)', boxShadow: '55px -90px 5px 0px rgba(0,0,0,.7) inset',}}/>
                            </div>
                        </div>
                    )
                })}
                </div>
            </div>
        )
    }
}
