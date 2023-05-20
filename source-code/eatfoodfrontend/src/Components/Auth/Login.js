import React, {Component, useState} from "react";
import Button from "../GeneralComps/Button";
import { useNavigate } from "react-router-dom";

export default function Login(props){

    const [loginState, setloginState] = useState(false)
    const [requestStatus, setRequestStatus] = useState("")
    const [username, setUsername] = useState("")
    const [password, setPassword] = useState("")
    const navigate = useNavigate()

    Login.defaultProps = {
        isLoggedIn: loginState,
    }

    function logUserIn(){
        props.handleLoginCallback(username)
        navigate("/dashboard/" + username)
    }

    function handleLogIn(e){
        e.preventDefault()
        const requestOptions = {
            method: 'POST',
            headers: {"Content-Type" : "application/json"},
            body: JSON.stringify({
                username : username,
                password : password,
            })
        }
        fetch('http://127.0.0.1:8000/api/login', requestOptions)
        .then(response => {
            if(response.ok){
                setloginState(true)
                logUserIn()
                console.log(loginState)
                return response.json()
            }else{
                return response.json()
            }
            // response.json()
        })
        .then(data => {
            console.log(data)
            setRequestStatus(data.Message)
        })
    }

    function usernameEntered(e){
        e.preventDefault()
        setUsername(e.target.value)
    }

    function passwordEntered(e){
        e.preventDefault()
        setPassword(e.target.value)
    }

    return(
        <div className="full-height flex w-full">

            <div className="h-full w-full flex flex-col self-center p-4">

                <div className="auth-form py-8">

                    <div style={{fontSize:30, fontWeight:'bolder'}} className="flex text-red-600 py-4">
                        eat <span className='italic font-light' >Food</span>
                    </div>
                    {/* <h1 className="font-h1 py-8">eatFood <br/>Login</h1> */}

                    <form className="login-form flex flex-col text-lg text-slate-500">

                        <div className="flex flex-col input1-div">
                            <input autoComplete="true" onChange={usernameEntered} className="input1" type="text" placeholder="Username" id="username"/>
                            <label for="username"> Username </label>
                        </div>

                        <div className="flex flex-col input2-div">
                            <input autoComplete="true" onChange={passwordEntered} className="input1" type="password" placeholder="Password" id="password"/>
                            <label for="password"> Password </label>
                            <p>{username}</p>
                        </div>

                        <input onClick={handleLogIn} className="login-button my-2 py-3 font-semibold bg-red-600 rounded-sm text-white" type="submit" value="Login"/>
                        <div>{requestStatus} **</div>
                        <div>{loginState}</div>
                    </form>

                    <div className="font-h5 py-4 text-red-600 font-medium"><a href="/">Forgotten Password?</a></div>

                </div>

            </div>
            
        </div>
    )
}