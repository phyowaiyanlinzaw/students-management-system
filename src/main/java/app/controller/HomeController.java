package app.controller;

import app.model.User;
import app.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Component
@ComponentScan("app")
@Controller
@RequestMapping("/")
public class HomeController {

    @GetMapping({"/welcome","/"})
    public String home(
            HttpSession session
    ) {

        // Check if user is logged in
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/user/login";
        }
        return "welcome";
    }
}
