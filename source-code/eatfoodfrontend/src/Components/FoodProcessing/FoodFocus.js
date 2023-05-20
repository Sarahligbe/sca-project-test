import React, {Component} from 'react';
import '../../index.css';

export default class FoodFocus extends Component {
    // constructor(props){
    //     super(props);
    //     this.state = {
    //         topRatedFoods : [
    //             {
    //                 id: 0,
    //                 vendorName: "Bola's Cuisines ",
    //                 item: "Pepper Rice",
    //                 description: "Rice with plenty heat",
    //                 img: ""
    //             },
    //             {
    //                 id: 1,
    //                 vendorName: "Bola's Cuisines ",
    //                 item:'Pepper Rice',
    //                 description: "Rice with plenty heat",
    //                 img: ""
    //             },
    //             {
    //                 id: 2,
    //                 vendorName: "Smokies's ",
    //                 item: "Barbecue Fish",
    //                 description: "Barbecue fish with fries",
    //                 img: ""
    //             },
    //             {
    //                 id: 3,
    //                 vendorName: "Osas's ",
    //                 item: "Oriental Noodles",
    //                 description: "Oriental style noodles",
    //                 img: ""
    //             },
    //             {
    //                 id: 4,
    //                 vendorName: "Charley Chow's ",
    //                 item: "Chicken Wings",
    //                 description: "Enjoy wings grilled with passion for ",
    //                 img: ""
    //             },
    //         ]
    //     }
    // }

    
    render () {
        if( this.props.price !== undefined ){

            return(
                <div  className= {' rounded-md w-full h-full'}>
                    {/* <div>
                        <div><input type='radio' value='Double Order'/></div>
                    </div> */}
                    <div className='pt-4'>
                        <div className='flex items-center'>
                            <div  className='ml-2 w-8 h-8 rounded-full border-y-red-600 border-2 flex'>
                            <img src={this.props.vendorLogo} alt="vendor's logo" className='rounded-full min-w-full min-h-full max-h-full bg-slate-400' 
                            style={{objectFit: 'cover'}}/>
                            </div>
    
                            <div className='text-sm text-slate-400 pl-2 font-bold'>{this.props.vendorName}</div>
                        </div>
                        
                        <div className='px-3'>
                        
                        <div className='relative space-x-4 py-4 text-gray-500 font-bold tracking-tight after:w-8 after:h-3 after:bg-red-600 hover:after:left-32 transition ease-in duration-300 hover:after:opacity-5 
                        after:absolute after:left-1 after:bottom-1 text-5xl'>{this.props.item}</div>
                        </div>
                    </div>
                    
                    <div className='group flex-col py-2 items-start rounded-lg p-3'>
                        <div className=' block'>
                            <div className='md:flex w-full'>
                                <div className='p-2 basis-2/3'>
                                    <div className='w-full h-52 ml-1 my-2'>
                                        <img src={this.props.foodImg} alt='item' className='rounded-lg min-w-full min-h-full max-h-full ' 
                                        style={{objectFit: 'cover'}}/>
                                    </div>
                                </div>
                                <div className='p-2 flex-row items-end self-end basis-1/3 mb-2'>
                                    {/* <div className='text-sm text-left align-bottom items-end'><span className='font-medium'>{this.props.vendorName}</span><span className='font-bold'>{this.props.item}</span></div> */}
                                    <div className='text-left font-medium text-slate-600 py-2 italic'><div className='not-italic font-bold text-sm text-slate-400 pt-2'>Description</div>{this.props.description}</div>
                                    <div className='py-2 text-left text-xl text-slate-700 font-black'><div className='not-italic font-bold text-sm text-slate-400 '>Price:</div>{"N" + this.props.price}</div>
                                    
                                    <div className='flex'>
                                        <button className='bg-red-600 px-6 py-2 rounded hover:bg-red-700 font-bold text-sm text-white' onClick={ () => {
                                                                                                                                    // alert("Do you wish to add this item to your tray?"), 
                                                                                                                                    this.props.addToTray(this.props.id)}
                                                                                                                                }>Add to Tray</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>
                        <div className="text-sm md:px-8 mt-5 text-slate-500 ">Items added to tray can be viewed by clicking the 'Open tray' button.</div>
                        </div>
                    </div>
                    
                </div>
            )

        }
        else{
            return(
                <div >
                <div className='px-4 pt-2 text-slate-800 text-sm'>Select an item to display here</div>
                <div  className= {this.props.price !== undefined? ' rounded-2xl w-full h-full' : 'animate-pulse'}>

                    <div className='pt-4 px-4'>
                        
                        <div className='flex items-center w-1/4 rounded-lg bg-slate-200'>
                            <div  className='ml-2 w-8 h-8 flex'>
                            </div>
    
                            <div className='text-sm text-red-400 pl-2 font-bold'>{this.props.vendorName}</div>
                        </div>
                        
                        <div className=''>
                        
                        <div className='relative space-x-4 py-4 mt-4 text-gray-500 font-bold tracking-tight h-14 w-1/2 rounded-md bg-slate-200 text-5xl'>{this.props.item}</div>
                        </div>
                    </div>
                    
                    <div className='group flex-col py-2 items-start rounded-lg p-3'>
                        <div className=' block'>
                            <div className='md:flex w-full'>
                                <div className='p-2 basis-2/3'>
                                    <div className='w-full h-52 ml-1 my-2 bg-slate-200 rounded-md'>
                                        
                                    </div>
                                </div>
                                <div className='p-2 flex-row items-end self-end basis-1/3 mb-2'>
                                    {/* <div className='text-sm text-left align-bottom items-end'><span className='font-medium'>{this.props.vendorName}</span><span className='font-bold'>{this.props.item}</span></div> */}
                                    <div className='text-left font-light text-slate-600 py-2  bg-slate-200 rounded-md h-10 mb-2'>{this.props.description}</div>
                                    <div className='py-2 text-left text-xl text-slate-700 font-extrabold  bg-slate-200 rounded-md h-10 w-1/2 mb-2'></div>
                                    
                                    <div>
                                        <button className=' px-6 py-2 font-bold text-sm text-white  bg-slate-200 rounded-md'></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div ></div>
                    </div>
                    
                </div>
                </div>
            )
        }
        
    }
}
