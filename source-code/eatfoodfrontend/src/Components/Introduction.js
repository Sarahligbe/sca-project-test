import React, {Component, useEffect} from "react";
import '../index.css';

export default class Introduction extends Component{

    constructor(props){
        super(props);
        this.state = {
            foodDescriptions : [{text: "Healthy", color: "green"}, {text:"Delicious", color:"orange"}, {text: "Tasty", color: "pink"},{text:"Peppery", color: "red"},{text:"Exciting", color: "purple"},{text:"Satisfying", color: "blue"}],
            activeFoodDescription : "Good",
            step: 0,
            nterval: null
        }
    };
    

    clickMe(){
        if(this.state.step < this.state.foodDescriptions.length){
            this.setState({
                activeFoodDescription: this.state.foodDescriptions[this.state.step],
                step: this.state.step + 1
            })
        }
        else{
            this.setState({
                step : 0
            })
        }
    }

    componentDidMount(){ 
        setInterval(() => {
            this.clickMe();
        }, 2000);
        
    }



    render(){

        return(
            <div className="content-center m-auto ">
                {this.props.user? (<div className="p-6 pb-0 font-bold text-right"><button className="rounded bg-red-400 px-3 py-1 text-slate-100">Hello {this.props.user}!</button></div>) : ""}
                <div className="content-center px-2"> 
                    <h1 
                        className="text-center pt-6 text-5xl font-black text-slate-800"> 
                        It's time to eat <span className="before:block before:absolute before:-inset-1 before:-skew-y-3 relative inline-block slide-in w-60"> 
                        <span className="italic font-extralight decoration-slice decoration-white relative slide-in" style={{color: `${this.state.activeFoodDescription.color}`, }}>{this.state.activeFoodDescription.text}</span></span> Food 
                
                    </h1>
                    <h1 
                        className="text-center text-sm p-3 py-6 lg:text-lg font-black text-gray-400 md:p-8 md:px-60"> 
                        The best of the best are ready to satisfy your tummy cravings today. <span className="font-semibold text-slate-500 text-sm md:text-lg">Now you can get order your favorite meals, drinks, snacks and grills at once and get then delivered to you at once</span>
                    </h1>

                </div>
                {/* <div className="m-auto"> 
                    <input 
                        placeholder="search something to eat" 
                        autoFocus 
                        className="flex m-auto enabled:hover:border-gray-400 border shadow-sm border-slate-300 p-2 px-4 border-spacing-5 rounded-2xl w-96 text-sm"
                    />
                </div> */}
            </div>
        )
    }
}