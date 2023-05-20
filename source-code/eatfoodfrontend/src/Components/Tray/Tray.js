import React, {Component} from "react";
import '../../App.css'


export default class Tray extends Component{
    constructor(props){
        super(props);
        this.state = {
            totalPrice : 5400
        }

    }

    
    render(){
        if(this.props.trayItems.length > 0){
            return(
                <div className=" md:h-96 overflow-y-scroll">
                    <div></div>
                    <div>
                        <div>
                            <div>
                                
                                <div>{this.props.trayItems.map(items => {
                                    return(
                                        <div className="flex md:p-2 pt-3 items-center justify-between">
                                            <div className="flex items-center">
                                                <div className="h-28 w-28 rounded-lg">
                                                    <img src={items.foodImg} alt="" className="min-h-full max-h-full min-w-full rounded-lg" style={{objectFit: "cover"}}/>
                                                </div>
                                                <div className="px-3 self-start">
                                                    <div className=" text-base font-semibold">
                                                        {items.item}
                                                    </div>
                                                    <div className=" text-sm">
                                                        {items.description}
                                                    </div>
                                                    <div className="font-bold text-gray-400 pt-2 text-sm">
                                                        {items.vendorName}
                                                    </div>
                                                    <div className="self-end">
                                                    <div className="font-extrabold text-lg">
                                                        {"N" + items.price}
                                                    </div>
                                                    
                                            </div>
                                                </div>
                                            </div>
                                            <div className="self-start">
                                                    <div>
                                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="w-6 h-6 float-right text-red-400">
                                                        <path strokeLinecap="round" strokeLinejoin="round" d="M6 18L18 6M6 6l12 12" />
                                                        </svg>
                                                    </div>
                                                    <div>double</div>
                                            </div>
                                            
                                        </div>
                                        )
                                    })}
                                </div>
                                <div className="flex flex-col md:flex-row justify-between p-8">
                                    <div className="flex text-lg font-bold justify-between">
                                        <div className="p-2 font-extrabold text-gray-600">Total Price:</div> 
                                        <div className="p-2 font-black">{"N" + this.props.totalPrice}</div>  
                                    </div>
                                    <button className="bg-red-600 text-white font-black text-xl rounded-md py-4 px-8 hover:bg-red-700">PAY/CHECKOUT</button>
                                </div>
                            </div>
                            <div className="md:px-8">
                                <form className="flex-col flex">
                                    <div className="flex flex-col my-2">
                                        <label for="name" className="text-sm px-1 font-semibold text-gray-600" >Contact</label>
                                        <input id="name" className="p-2 text-xs border-gray-300 border my-1" placeholder="Contact Number" name="Contact" lab />
                                        <div className="px-2 pt-2 text-xs font-medium">*Your contact is required to reach you.</div>
                                    </div>
                                    <div className="flex flex-col mt-2">
                                        <label for="req" className="text-sm px-1 font-semibold text-gray-600" >Request</label>
                                        <input id="req" className="p-2 text-xs border-gray-300 border my-1" placeholder="Additional request"/>
                                        <div className="p-2 text-xs font-medium">*Terms and Conditions apply to request.</div>
                                    </div>
                                    
                                </form>
                                
                            </div>
                        </div>
    
                        <div></div>
                    </div>
                    <div className="text-sm md:px-8 mt-5">Our response time is now 30 - 45 mins after payment. We are working tirelessly to improve that. Thank you!</div>
                </div>
            )
        }else{
            return(
                <div>
                    <div></div>
                    <div>
                        <div className="max-md:py-32">
                            <div className="max-h-56 flex h-56 justify-around mt-8"><img src={"https://cdn-icons-png.flaticon.com/512/365/365723.png"} alt="" className="max-h-full min-h-full max-w-full" style={{objectFit: "cover"}}/></div>
                            <div className="text-2xl text-center text-slate-300 font-bold p-8"> No Item Has Been Added To Your Tray Yet</div>
                            {/* <div>
                                
                                <div>{this.props.trayItems.map(items => {
                                    return(
                                        <div className="flex md:p-2 pt-2 items-center justify-between">
                                            <div className="flex items-center">
                                                <div className="max-h-28 h-28 w-28 rounded-lg">
                                                    <img src={items.foodImg} alt="" className="min-h-full max-h-full min-w-full rounded-lg" style={{objectFit: "cover"}}/>
                                                </div>
                                                <div className="p-3 ">
                                                    <div className=" text-base font-semibold">
                                                        {items.item}
                                                    </div>
                                                    <div className=" text-sm">
                                                        {items.description}
                                                    </div>
                                                    <div className="font-bold text-gray-400 pt-2 text-sm">
                                                        {items.vendorName}
                                                    </div>
                                                </div>
                                            </div>
                                            <div className="">
                                                
                                                <div>
                                                    <div>remove</div>
                                                    <div>double</div>
                                                    
                                                </div>
                                                <div>
                                                    <div className="font-semibold">
                                                        {"N" + items.price}
                                                    </div>
                                                    
                                                </div>
                                            </div>
                                        </div>
                                        )
                                    })}
                                </div>
                                <div className="flex flex-col md:flex-row justify-between p-8">
                                    <div className="flex text-lg font-bold justify-between">
                                        <div className="p-2 font-extrabold text-red-600">Total Price:</div> 
                                        <div className="p-2 font-black">{"N" + this.state.totalPrice}</div>  
                                    </div>
                                    <button className="bg-red-600 text-white font-extrabold rounded-md py-2 px-8">PAY</button>
                                </div>
                            </div>
                            <div className="md:px-8">
                                <form className="flex-col flex">
                                    <div className="flex flex-col my-2">
                                        <label for="name" className="text-sm px-1 font-semibold text-gray-600" >Contact</label>
                                        <input id="name" className="p-2 text-xs border-gray-300 border my-1" placeholder="Contact Number" name="Contact" lab />
                                        <div className="px-2 pt-2 text-xs font-medium">*Your contact is required to reach you.</div>
                                    </div>
                                    <div className="flex flex-col mt-2">
                                        <label for="req" className="text-sm px-1 font-semibold text-gray-600" >Request</label>
                                        <input id="req" className="p-2 text-xs border-gray-300 border my-1" placeholder="Additional request"/>
                                        <div className="p-2 text-xs font-medium">*Terms and Conditions apply to request.</div>
                                    </div>
                                    
                                </form>
                                
                            </div> */}
                        </div>
    
                        <div></div>
                    </div>
                    {/* <div className="text-sm md:px-8 mt-5 items-end align-middle flex align-center justify-center">Our response time is now 30 - 45 mins after payment. We are working tirelessly to improve that. Thank you!</div> */}
                </div>
            )
        }
        
    }
}