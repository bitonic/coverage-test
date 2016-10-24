import Lib

import System.Process
import System.Environment
import System.Directory

main :: IO ()
main = do
  [hpcPath] <- lines <$> readProcess "stack" ["path", "--local-hpc-root"] ""
  let extraTixFilesPath = hpcPath ++ "/extra-tix-files/"
  createDirectoryIfMissing True extraTixFilesPath
  currentEnv <- getEnvironment
  let cp = (proc "coverage-test-exe" []){ env = Just (("HPCTIXDIR", extraTixFilesPath) : currentEnv) }
  (_, _, _, ph) <- createProcess cp
  waitForProcess ph
  func1
