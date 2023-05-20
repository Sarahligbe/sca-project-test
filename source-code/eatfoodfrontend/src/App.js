import Navigation from './Components/Navigation/Navigation';
import './App.css';
import React, { Component } from 'react';
import Introduction from './Components/Introduction';
import {BrowserRouter, Route, Routes, Link} from 'react-router-dom'
import Homepage from './Components/Homepage/Homepage';
import Outro from './Components/Navigation/Outroduction';
import Login from './Components/Auth/Login';

class App extends Component {
  constructor(props){
    super(props);
    this.state = {
      user: null
    }
    this.getUserCallback = this.getUserCallback.bind(this)
  }

  renderHomepage(){
    return(
      <div>
        {/* <Navigation/>
        <Introduction/> */}
        <Introduction user = {this.state.user}/>
        <div className='lg:px-24'>
          <Homepage/>
        </div>
        <Outro/>
      </div>
    )
  }

  getUserCallback(callback){
    console.log("callback run")
    this.setState({
      user: callback
    })
  }

  render() {
    return (
      <div className=''>
        
        <div className='flex flex-col'>
          <BrowserRouter>
            <div>
              <Navigation
                user = {this.state.user}
              />
              <div className='lg:px-24'>
              {/* <Homepage/> */}
              </div>
            </div>
            <Routes>
              <Route>
                <Route path='/' element={this.renderHomepage()}/>
                <Route path='/login' element={<Login handleLoginCallback={this.getUserCallback}/>}/>
                <Route path='/dashboard/:user' element={this.renderHomepage()}/>
              </Route>
            </Routes>
          </BrowserRouter>
        </div>
        <div className=''>
        </div>
      </div>

    );
  }

}

export default App;
