import React,  {Component} from 'react';
import '../../index.css'
import FoodDisplay from '../FoodProcessing/FoodDisplay';


export default class Homepage extends Component{
    constructor(props){
        super(props)
        this.state = {
            expandItem : 0,
            data : null,
            vendorsList : []
        }
    }
    
    componentDidMount(){
        fetch('http://127.0.0.1:8000/api/')
        .then(response => response.json())
        .then(data => this.setState({data: data.data}))

        this.vendorList()
    }

    vendorList(){
        fetch('http://127.0.0.1:8000/api/vendors')
        .then(response => response.json())
        .then(data => this.setState({vendorsList: data}))
    }

    renderFoodDisplay() {
        return(
            <div>
                <FoodDisplay
                />  
            </div>
        )
    }
    inventoryExpand(i){ 
        this.setState({
            expandItem : i
    });
    }

    render() {
        return(
            <div>
                {/* <div> Now, Next, Later </div>
                <div>{this.state.data}</div>
                <div>
                    {this.state.vendorsList.map(vendor => (
                        <div>
                            <div>{vendor.name}</div>
                        </div>
                    ))}
                </div> */}
                <div>
                    <div>{this.renderFoodDisplay()}</div>
                </div>
                <div>Sumptous Recipes and Secret Mixes</div>
            </div>

        )
    }
}