import React, {Component} from "react";
import "../../index.css"

export default class FoodItems extends Component {
    constructor(props){
        super(props)
        this.state = {
            trayItems : [
                {
                    id: 0,
                    option: "Main",
                    description: "What will you have for main course?",
                    img: "https://images.unsplash.com/photo-1546069901-5ec6a79120b0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1476&q=80",
                },
                {
                    id: 1,
                    option: "Drinks",
                    description: "Would you like to drink anything cold/hot?",
                    img: "https://images.unsplash.com/photo-1551024709-8f23befc6f87?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=957&q=80",
                },
                {
                    id: 2,
                    option: "Grills",
                    description: "Barbecue, Suya, Fries and other Grills",
                    img: "https://images.unsplash.com/photo-1534797258760-1bd2cc95a5bd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80",
                },
                {
                    id: 3,
                    option: "Snacks",
                    description: "Want to snack on something light?",
                    img: "https://images.unsplash.com/photo-1604911181572-ee2ad5a0f6db?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
                },

            ],
            scrollingPosition: null,
            scrollOb : document.querySelector('.food-items'),
        }
    }

    collapseFoodItemDisplay(){
        const scrollObj = document.querySelector('.food-items')
        const windowHeight = window.innerHeight
        const scrollObjPos= scrollObj.getBoundingClientRect()

        if(scrollObjPos.top === 0){
            document.body.style.overflow = ""
            console.log("at top")
            const x = scrollObj.children[0]
            console.log(x.childElementCount)
            console.log(x)
            x.style.setProperty("display","flex", "important")
            console.log(typeof(x))
            var nodes = x.childNodes;
            for( var i = 0; i < nodes.length; i++){
                console.log(nodes[i] + "  " + i)
                var y = document.createElement('div')
                var p = document.createTextNode("hey")
                y.appendChild(p)
                var j = nodes[i]
                var t = j.childNodes[0]
                console.log(t)
                var btn = document.querySelectorAll(".description")      
                btn.forEach(button => {
                    button.classList.add("max-sm:hidden")
                })


            }
            x.children.forEach(element => {
                element.style.setProperty("height","3rem", "important")
            });
        }else{
            document.body.style.overflow = "scroll"
            console.log("no")
            const elseX = scrollObj.children[0]
            var elseNodes = elseX.childNodes;
            for( var o = 0; o < elseNodes.length; o++){
                console.log(nodes[o] + "  " + i)
                var elseJ = nodes[o]
                var elseT = elseJ.childNodes[0]
                console.log(elseT)
                var elseBtn = document.querySelectorAll(".description")      
                elseBtn.forEach(elseButton => {
                    elseButton.style.display = "block"
                    elseButton.classList.remove("hidden")
                })
                console.log(elseBtn)        
                elseBtn.style.display = "block"
                console.log(elseJ)
                
            }
        }
        

        console.log(windowHeight, scrollObjPos.top, scrollObjPos.right)
    }

    componentDidMount(){
        
        window.addEventListener('scroll', () => this.collapseFoodItemDisplay())
    }

    render() {
        return(
            <div className="mb-8 food-items" >
                <div className="grid grid-cols-2 md:grid-cols-4  gap-1">
                    {this.state.trayItems.map(items => {
                        return(
                            <div className="m-auto bg-cover col-span-1 hover:scale-95 " >
                            <button className="m-2 basis-1/4 bg-cover rounded-xl border-indigo-300 focus:outline-none focus:ring-2 focus:scale-90 focus:ring-red-500 active:ring-2 active:ring-red-500 focus:ring-offset-2 text-gray-400 hover:ring-4 transition-all hover:ring-red-400 hover:text-gray-500 outline-gray-300 outline outline-1 max-h-56 "
                                onClick={() => this.props.expandFoodItem(items.id)}
                                style={{backgroundImage: `url(${items.img})`}}
                            >
                                <div className="w-full max-h-fit"
                                    
                                >
                                    <div>
                                        {/* <img src={items.img} alt="" className=""/> */}
                                    </div>
                                    <div
                                        className="hover:shadow-lg rounded-xl shadow-inner"
                                        style={{boxShadow: '95px -70px 5px 0px rgba(0,0,0,.8) inset',}}
                                    // style={{backgroundColor: 'rgba(0,0,0,.5)', zIndex: 0}}
                                    >
                                        <div 
                                            className=""
                                            style={{}}>
                                            <div className="text-xl font-black text-left pt-5 pb-2 px-2 text-white">{items.option}</div>
                                            <div className="description text-left text-white pl-2 pr-6 py-2 text-xs font-medium">{items.description}</div>
                                        </div>
                                    </div>
                                </div>
                            </button>
                            </div>
                        )
                    })}
                    
                </div>
                <div>

                </div>
            </div>
        )
    }
}