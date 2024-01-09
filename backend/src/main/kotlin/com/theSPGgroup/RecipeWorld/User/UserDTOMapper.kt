import com.theSPGgroup.RecipeWorld.User.User
import com.theSPGgroup.RecipeWorld.User.UserDTO

class UserDTOMapper {
    companion object {
        fun mapUserToUserDTO(user: User): UserDTO {
            return UserDTO(
                username = user.username,
            )
        }
    }
}
