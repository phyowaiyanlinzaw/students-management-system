package app.controller;

import app.model.User;
import app.service.UserServiceImpl;
import app.util.PasswordHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/user")
@ComponentScan("app")
@Component
public class UserController {

    @Autowired
    UserServiceImpl userService;

    @GetMapping("/login")
    public ModelAndView login() {
        return new ModelAndView("user-login","user",new User());
    }

    @PostMapping("/login")
    public String login(
            @ModelAttribute("user") User user,
            ModelMap modelMap,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ){

        try{
            if(user.getUserIdentifier().trim().isEmpty() || user.getUserPassword().trim().isEmpty()){
                modelMap.addAttribute("message","emptyError");
                return "user-login";
            }
        }catch (NullPointerException e){
            modelMap.addAttribute("message","emptyError");
            return "user-login";
        }

        boolean isEmail = user.getUserIdentifier().contains("@");

        List<User> usersList = userService.getAllUsersAndAdmin();
        for (User u : usersList) {

            if (isEmail) {
                if (u.getUserEmail().equals(user.getUserIdentifier())) {
                    if (PasswordHelper.checkPassword(user.getUserPassword(), u.getUserPassword())) {
                        session.setAttribute("currentUser", u);
                        redirectAttributes.addFlashAttribute("message", "loginSuccess");
                        return "redirect:/";
                    }else {
                        modelMap.addAttribute("message", "loginError");
                        return "user-login";
                    }
                }
            } else {
                if (u.getUserName().equals(user.getUserIdentifier())) {
                    System.out.println("Same username");
                    if (PasswordHelper.checkPassword(user.getUserPassword(), u.getUserPassword())) {
                        System.out.println("Same password");
                        session.setAttribute("currentUser", u);
                        redirectAttributes.addFlashAttribute("message", "loginSuccess");
                        return "redirect:/";
                    }else {
                        modelMap.addAttribute("message", "loginError");
                        return "user-login";
                    }
                }
            }
        }

        return "user-login";
    }

    @GetMapping("/register")
    public ModelAndView register(){
        return new ModelAndView("user-register","user",new User());
    }

    @PostMapping("/register")
    public String register(
            @ModelAttribute("user") User user,
            RedirectAttributes redirectAttributes,
            ModelMap modelMap
    ){

        List<User> usersList = userService.getAllUsers();
        for (User u : usersList) {
            if(u.getUserEmail().equals(user.getUserEmail())){
                modelMap.addAttribute("message","emailDupeError");
                return "user-register";
            }
        }

        try{
            if(user.getUserName().trim().isEmpty() || user.getUserEmail().trim().isEmpty() || user.getUserPassword().trim().isEmpty()){
                modelMap.addAttribute("message","emptyError");
                return "user-register";
            }
        }catch (NullPointerException e){
            modelMap.addAttribute("message","emptyError");
            return "user-register";
        }

        if (!user.getUserConfirmPassword().equals(user.getUserPassword())){
            modelMap.addAttribute("message","passwordNotMatch");
            return "user-register";
        }

        int registerUserResult = userService.registerUser(user);

        if(registerUserResult==0){
            modelMap.addAttribute("message","registerError");
            return "user-register";
        }

        modelMap.addAttribute("message","registerSuccess");
        return "redirect:/user/login";
    }

    @GetMapping("/list")
    public String userList(ModelMap modelMap){
        List<User> users = userService.getAllUsers();
        modelMap.addAttribute("users",users);

        return "user-list";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/";
    }
}
