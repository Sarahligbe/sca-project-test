import React, { Component } from 'react';
import {Link, Outlet} from 'react-router-dom'


import '../../App.css'

export default class Navigation extends Component {
    constructor(props){
        super(props);
        this.state = {
            navDrawn: false,
            expandMenuPopUp: false,
            user: '',
        }
    }
    // const [navDrawn, setnavDrawn] = useState(false)

    // navDrawn = false;

    drawNav(){
        this.setState({
            navDrawn : !this.state.navDrawn
        })
        
        console.log("nav clicked", this.state.navDrawn)
    }

    render() {
        const menuItems = [
            {menu : 'HOW WE SERVE', subMenu: [], content: 'We are committed to making available all your favorite choices of food in the moments that you need them', urlLink: '/'},
            {menu : 'WHAT WE PROVIDE', subMenu: [], content: 'We are committed to making available all your favorite choices of food in the moments that you need them', urlLink: '/'},
            {menu : 'LOGIN', subMenu: [], content: 'We are committed to making available all your favorite choices of food in the moments that you need them', urlLink: '/login'}
        ]
        

        return(
            <div className='flex p-3 m-auto bg-red-700'>
                <div className='font-medium text-white mx-8'>
                    <button style={{fontSize:30, fontWeight:'bolder'}} className="flex">
                        eat <span className='italic font-light' >Food</span>
                    </button>
                </div>
                {/* <div>{this.props.user}</div> */}
                <div className='hidden md:grid relative align-middle w-full justify-end'>
                    <div className='m-auto align-middle justify-center'>
                        <ul className='md:flex'>
                            {menuItems.map(menu => {
                                return (
                                    <li className='px-4 align-top'>
                                    <Link to={menu.urlLink}>
                                    <button className='text-white px-5 py-2 -m-3 items-start rounded-md p-3 hover:bg-red-600 font-medium text-sm'>{menu.menu}</button>
                                    </Link>
                                    </li>
                                )
                            })}
                        </ul>
                    </div>
                </div>
                <div className="md:hidden relative w-full text-right justify-end " onClick={() => this.drawNav() }>
                <svg onClick={() => this.drawNav()}   xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="white" class="w-8 h-8 float-right m-1">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5M12 17.25h8.25" />
                </svg>
                </div>
                

                <div className={this.state.navDrawn === true ? "flex-row absolute right-0 justify-end bg-red-700 text-white p-3 w-1/2 rounded-lg z-40 slide-in-stay" : "hidden"}>
                    
                <div onClick={() => this.drawNav()} className="text-right float-right">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="w-6 h-6">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </div>
                        <ul className='pt-5 pr-3'>
                            {menuItems.map(menu => {
                                return (
                                <div>
                                    <Link to={menu.urlLink}>
                                    <li className='p-2 text-right'>
                                    <button href='#' onClick={[() => this.setState({expandMenuPopUp: !this.state.expandMenuPopUp})]} className=' px-3 py-2 items-start rounded-lg p-1 hover:bg-red-600 font-medium text-sm'>{menu.menu}</button>
                                    </li>
                                    </Link>
                                    <div className={this.state.expandMenuPopUp === true? 'block absolute top-1 bg-red-500' : 'hidden'}>
                                        <div>
                                            {menu.content}
                                        </div>
                                    </div>
                                </div>
                                )
                            })}
                        </ul>
                        
                        
                    
                </div>
                <Outlet/>
            </div>
            )
    }
}