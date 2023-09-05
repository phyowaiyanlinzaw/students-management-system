package app.controller;

import app.model.User;
import app.service.UserServiceImpl;
import app.util.PasswordHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
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
        return new ModelAndView("user-login", "user", new User());
    }

    @PostMapping("/login")
    public String login(
            @ModelAttribute("user") User user,
            ModelMap modelMap,
            HttpSession session
    ) {

        try {
            if (user.getUserIdentifier().trim().isEmpty() || user.getUserPassword().trim().isEmpty()) {
                modelMap.addAttribute("message", "emptyError");
                return "user-login";
            }
        } catch (NullPointerException e) {
            modelMap.addAttribute("message", "emptyError");
            return "user-login";
        }

        boolean isEmail = user.getUserIdentifier().contains("@");

        List<User> usersList = userService.getAllUsersAndAdmin();
        for (User u : usersList) {

            if (isEmail) {
                System.out.println(u.getUserEmail());
                if (u.getUserEmail().equals(user.getUserIdentifier())) {
                    if (PasswordHelper.checkPassword(user.getUserPassword(), u.getUserPassword())) {
                        session.setAttribute("currentUser", u);
                        return "redirect:/";
                    } else {
                        modelMap.addAttribute("message", "loginError");
                        return "user-login";
                    }
                }
            } else {
                if (u.getUserName().equals(user.getUserIdentifier())) {
                    if (PasswordHelper.checkPassword(user.getUserPassword(), u.getUserPassword())) {
                        session.setAttribute("currentUser", u);
                        return "redirect:/";
                    } else {
                        modelMap.addAttribute("message", "loginError");
                        return "user-login";
                    }
                }
            }
        }

        return "user-login";
    }

    @GetMapping("/register")
    public ModelAndView register() {
        return new ModelAndView("user-register", "user", new User());
    }

    @PostMapping("/register")
    public String register(
            @ModelAttribute("user") User user,
            RedirectAttributes redirectAttributes,
            ModelMap modelMap
    ) {

        List<User> usersList = userService.getAllUsers();
        for (User u : usersList) {
            if (u.getUserEmail().equals(user.getUserEmail())) {
                modelMap.addAttribute("message", "emailDupeError");
                return "user-register";
            }
        }

        try {
            if (user.getUserName().trim().isEmpty() || user.getUserEmail().trim().isEmpty() || user.getUserPassword().trim().isEmpty()) {
                modelMap.addAttribute("message", "emptyError");
                return "user-register";
            }
        } catch (NullPointerException e) {
            modelMap.addAttribute("message", "emptyError");
            return "user-register";
        }

        if (!user.getUserConfirmPassword().equals(user.getUserPassword())) {
            modelMap.addAttribute("message", "passwordNotMatch");
            return "user-register";
        }

        int registerUserResult = userService.registerUser(user);

        if (registerUserResult == 0) {
            modelMap.addAttribute("message", "registerError");
            return "user-register";
        }

        redirectAttributes.addFlashAttribute("message", "registerSuccess");
        return "redirect:/user/login";
    }

    @GetMapping("/list")
    public String userList(ModelMap modelMap) {
        List<User> users = userService.getAllUsers();
        modelMap.addAttribute("users", users);
        return "user-list";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/profile")
    public ModelAndView userProfile(HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        return new ModelAndView("user-profile", "user", currentUser);
    }

    @GetMapping("/edit")
    public ModelAndView editProfile(
            @RequestParam("userId") int userId
    ) {
        User user = userService.getOneUser(userId);
        return new ModelAndView("user-profile", "user", user);
    }

    @PostMapping("/edit")
    public String editProfile(
            @ModelAttribute("user") User user,
            ModelMap modelMap,
            @RequestParam("cPassword") String cPassword,
            @RequestParam("password") String password,
            @RequestParam("userId") int userId,
            HttpSession session,
            RedirectAttributes redirectAttributes

    ) {

        try {
            if (user.getUserName().trim().isEmpty() || user.getUserEmail().trim().isEmpty() || password.trim().isEmpty()) {
                modelMap.addAttribute("message", "emptyError");
                return "user-profile";
            }
        } catch (NullPointerException e) {
            modelMap.addAttribute("message", "emptyError");
            return "user-profile";
        }

        if (!cPassword.equals(password)) {
            modelMap.addAttribute("message", "passwordNotMatch");
            return "user-profile";
        }


        user.setUserId(userId);
        user.setUserPassword(PasswordHelper.hashPassword(password));

        int editUserResult = userService.updateUser(user);

        if (editUserResult == 0) {
            modelMap.addAttribute("message", "editError");
            return "user-profile";
        }
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser.getUserRole().equals("admin")) {
            redirectAttributes.addFlashAttribute("message", "editSuccess");
            return "redirect:/user/list";
        }

        session.setAttribute("currentUser", user);
        redirectAttributes.addFlashAttribute("message", "editSuccess");
        return "redirect:/welcome";
    }

    @GetMapping("/delete")
    public String deleteUser(
            @RequestParam("userId") int userId,
            RedirectAttributes redirectAttributes
    ) {
        int deleteResult = userService.deleteUser(userId);
        if (deleteResult == 0) {
            redirectAttributes.addFlashAttribute("message", "deleteError");
            return "redirect:/user/list";
        }
        redirectAttributes.addFlashAttribute("message", "deleteSuccess");
        return "redirect:/user/list";
    }
}
